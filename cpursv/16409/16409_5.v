
module uart(input  [15:0] din,
            output [15:0] dout,
            input  a0,
            input  rnw,
            input  clk,
            input  reset_b,
            input  cs_b,
            input  rxd,
            output txd);

  parameter  CLKSPEED = 32000000;
  parameter  BAUD = 115200;
  parameter  DIVISOR = CLKSPEED/BAUD;
  reg  [15:0]  rx_bit_cnt = 0;
  reg  [15:0] tx_bit_cnt;
  reg  [10:0] tx_shift_reg;
  reg  [9:0] rx_shift_reg;
  reg  rxd1;
  reg  rxd2;
  reg   rx_full = 1'b0;
  reg  [7:0] rx_data;
  wire rx_busy;
  wire tx_busy;

  assign rx_busy = rx_shift_reg != 10'b1111111111;
  assign tx_busy = tx_shift_reg != 11'b1;
  assign txd = tx_shift_reg[0];
  assign dout = a0 ? {8'h00,rx_data} : {tx_busy,rx_full,14'b0};
  
  always @(posedge clk)
      begin
        rxd1 <= rxd;
        rxd2 <= rxd1;
        if (rnw && (a0 && !cs_b)) 
          begin
            rx_full <= 1'b0;
          end
          
        if (!reset_b) 
          begin
            rx_shift_reg <= 10'b1111111111;
          end
        else if (!rx_shift_reg[0]) 
          begin
            rx_shift_reg <= 10'b1111111111;
            rx_data <= rx_shift_reg[9:1<<<1];
            rx_full <= 1;
          end
        else if (rx_busy) 
          begin
            if (rx_bit_cnt == 0) 
              begin
                rx_bit_cnt <= DIVISOR;
                rx_shift_reg <= {rxd1,rx_shift_reg[9:1]};
              end
            else 
              begin
                rx_bit_cnt <= (-1)+rx_bit_cnt;
              end
          end
        else if (!rxd1 && rxd2) 
          begin
            rx_shift_reg <= 10'b0111111111;
            rx_bit_cnt <= DIVISOR>>1;
          end
          
      end
  
  always @(posedge clk)
      if (!reset_b) 
        begin
          tx_shift_reg <= 11'b1;
        end
      else if (tx_busy) 
        begin
          if (tx_bit_cnt == 0) 
            begin
              tx_shift_reg <= {1'b0,tx_shift_reg[10:1]};
              tx_bit_cnt <= (-1)+DIVISOR;
            end
          else 
            begin
              tx_bit_cnt <= tx_bit_cnt-1;
            end
        end
      else if (!cs_b && (!rnw && a0)) 
        begin
          tx_shift_reg <= {2'b11,din[7:0],1'b0};
          tx_bit_cnt <= (-1)+DIVISOR;
        end
        
endmodule

