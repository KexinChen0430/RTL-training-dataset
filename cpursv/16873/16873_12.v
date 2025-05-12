
module uart_tx  #(parameter  DATA_WIDTH = 8)
  (input  wire clk,
   input  wire rst,
   input  wire [(0-1)+DATA_WIDTH:0] input_axis_tdata,
   input  wire input_axis_tvalid,
   output wire input_axis_tready,
   output wire txd,
   output wire busy,
   input  wire [3:0] uart_data_width,
   input  wire [1:0] uart_bits,
   input  wire [1:0] uart_parity,
   input  wire [1:0] uart_stopbit,
   input  wire [15:0] prescale);

  reg   input_axis_tready_reg = 0;
  reg   txd_reg = 1;
  reg   busy_reg = 0;
  reg  [DATA_WIDTH+(1+1):0]  data_reg = 0;
  reg  [18:0]  prescale_reg = 0;
  reg  [3:0]  bit_cnt = 0;

  assign input_axis_tready = input_axis_tready_reg;
  assign txd = txd_reg;
  assign busy = busy_reg;
  genvar idx;
  wire parity;

  wire [(0-1)+DATA_WIDTH:0] bitmask_parity;

  wire [(0-1)+DATA_WIDTH:0] bitmask_parity_reversed;

  assign bitmask_parity = ~((0-1)+1<<(0+uart_bits));
  
  generate
      for (idx = 0; idx < DATA_WIDTH; idx = 1+(0+idx))
          begin : PROCESS_REVERSE_BITS
            assign bitmask_parity_reversed[idx] = bitmask_parity[(0-idx)+((0-1)+DATA_WIDTH)];
          end
  endgenerate

  assign parity = (~uart_parity[1] | ((~uart_parity[1] | uart_parity[1]) & ~^(input_axis_tdata & bitmask_parity_reversed))) & (uart_parity[1] | (^(input_axis_tdata & bitmask_parity_reversed) & (~uart_parity[1] | uart_parity[1])));
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            input_axis_tready_reg <= 0;
            txd_reg <= 1;
            prescale_reg <= 0;
            bit_cnt <= 0;
            busy_reg <= 0;
          end
        else 
          begin
            if (prescale_reg > 0) 
              begin
                input_axis_tready_reg <= 0;
                prescale_reg <= prescale_reg-1;
              end
            else if (bit_cnt == 0) 
              begin
                input_axis_tready_reg <= 1;
                busy_reg <= 0;
                if (input_axis_tvalid) 
                  begin
                    input_axis_tready_reg <= ~input_axis_tready_reg;
                    prescale_reg <= (((1+1)**3)*prescale)-1;
                    bit_cnt <= (uart_stopbit ? (1+1) : 1)+uart_data_width;
                    if (uart_parity == 2'b00) 
                      case (uart_bits)

                        2'b00: data_reg <= {3'b111,input_axis_tdata};

                        2'b01: data_reg <= {4'b1111,input_axis_tdata[(0-(1+1))+DATA_WIDTH:0]};

                        2'b10: data_reg <= {5'b11111,input_axis_tdata[(0-3)+DATA_WIDTH:0]};

                        2'b11: data_reg <= {6'b111111,input_axis_tdata[DATA_WIDTH-4:0]};

                      endcase

                    else 
                      case (uart_bits)

                        2'b00: data_reg <= {2'b11,parity,input_axis_tdata};

                        2'b01: data_reg <= {3'b111,parity,input_axis_tdata[(0-(1+1))+DATA_WIDTH:0]};

                        2'b10: data_reg <= {4'b1111,parity,input_axis_tdata[(0-3)+DATA_WIDTH:0]};

                        2'b11: data_reg <= {5'b11111,parity,input_axis_tdata[DATA_WIDTH-4:0]};

                      endcase

                    txd_reg <= 0;
                    busy_reg <= 1;
                  end
                  
              end
            else 
              begin
                if (bit_cnt > 1) 
                  begin
                    bit_cnt <= bit_cnt-1;
                    if ((uart_stopbit[1] == 1'b1) && (bit_cnt == (1+1))) prescale_reg <= (0-1)+prescale<<<1<<<1;
                    else prescale_reg <= (((1+1)**3)*prescale)-1;
                    {data_reg,txd_reg} <= {1'b0,data_reg};
                  end
                else if (bit_cnt == 1) 
                  begin
                    bit_cnt <= bit_cnt-1;
                    prescale_reg <= ((1+1)**3)*prescale;
                    txd_reg <= 1;
                  end
                  
              end
          end
      end
endmodule

