
module uart(input  wire clk,
            input  wire rx,
            output wire tx,
            output wire [7:0] data_o,
            output wire ack_o,
            input  wire [7:0] data_i,
            input  wire ack_i,
            output wire pop_o);

  wire trig_baud16;
  wire trig_baud;
  reg  [10:0] bauddiv_counter_ff;

  
  always @(posedge clk)
      begin
        if (bauddiv_counter_ff == 0) 
          begin
            bauddiv_counter_ff <= 11'd325;
          end
        else 
          begin
            bauddiv_counter_ff <= bauddiv_counter_ff-1;
          end
      end
  assign trig_baud16 = bauddiv_counter_ff == 4'd0;
  reg  [3:0] baudrate_counter_ff;

  
  always @(posedge clk)
      begin
        if (trig_baud16) baudrate_counter_ff <= 1+baudrate_counter_ff;
          
      end
  reg  trig_baud_ff;

  
  always @(posedge clk)
      begin
        trig_baud_ff <= (baudrate_counter_ff == 4'd0) && trig_baud16;
      end
  assign trig_baud = trig_baud_ff;
  reg  [1:0] rx_hist_ff;

  
  always @(posedge clk)
      rx_hist_ff <= {rx_hist_ff[0],rx};
  wire  rx_posedge = rx_hist_ff[1:0] == 2'b01;

  wire  rx_negedge = rx_hist_ff[1:0] == 2'b10;

  reg  [4:0] rx_counter_ff;

  reg  [4:0] rx_poscounter_ff;

  wire 
       trig_next_uartbit = rx_negedge || (rx_counter_ff == 5'd17) || rx_posedge;

  
  always @(posedge clk)
      begin
        if (trig_next_uartbit) 
          begin
            rx_counter_ff <= 0;
            rx_poscounter_ff <= 0;
          end
        else 
          begin
            if (trig_baud16) 
              begin
                rx_counter_ff <= 1+rx_counter_ff;
                if (rx_hist_ff[0] == 1'b1) rx_poscounter_ff <= rx_poscounter_ff+1;
                  
              end
              
          end
      end
  wire  currbit = rx_poscounter_ff > 8;

  reg  [7:0] rxbuf_ff;

  
  always @(posedge clk)
      begin
        if (trig_next_uartbit) rxbuf_ff <= {currbit,rxbuf_ff[7:1]};
          
      end
  assign data_o = rxbuf_ff;
  reg  [3:0] rx_frame_counter_ff;

  
  always @(posedge clk)
      begin
        if (trig_next_uartbit) 
          begin
            if (rx_frame_counter_ff > 4'd8) 
              begin
                if (rx_negedge) 
                  begin
                    rx_frame_counter_ff <= 0;
                  end
                  
              end
            else 
              begin
                rx_frame_counter_ff <= 1+rx_frame_counter_ff;
              end
          end
          
      end
  reg  rx_pop_ff;

  
  always @(posedge clk)
      begin
        rx_pop_ff <= trig_next_uartbit && (rx_frame_counter_ff == 4'd8);
      end
  assign ack_o = rx_pop_ff;
  reg  [3:0] tx_frame_counter_ff;

  
  always @(posedge clk)
      begin
        if (ack_i) 
          begin
            tx_frame_counter_ff <= 0;
          end
        else if (trig_baud) 
          begin
            tx_frame_counter_ff <= tx_frame_counter_ff+1;
          end
          
      end
  assign pop_o = tx_frame_counter_ff > 4'd9;
  reg  [10:0] txbuf_ff;

  
  always @(posedge clk)
      begin
        if (ack_i) 
          begin
            txbuf_ff <= {1'b1,data_i,1'b0,1'b1};
          end
        else if (trig_baud) 
          begin
            txbuf_ff <= {1'b1,txbuf_ff[9:1]};
          end
          
      end
  assign tx = txbuf_ff[0];
endmodule

