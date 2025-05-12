
module uart_rx  #(parameter  DATA_WIDTH = 8)
  (input  wire clk,
   input  wire rst,
   output wire [(-1)+DATA_WIDTH:0] output_axis_tdata,
   output wire output_axis_tvalid,
   input  wire output_axis_tready,
   input  wire rxd,
   output wire busy,
   output wire overrun_error,
   output wire frame_error,
   input  wire [3:0] uart_data_width,
   input  wire [1:0] uart_parity,
   input  wire [1:0] uart_stopbit,
   input  wire [15:0] prescale);

  reg  [(-1)+DATA_WIDTH:0]  output_axis_tdata_reg = 0;
  reg   output_axis_tvalid_reg = 0;
  reg   rxd_reg = 1;
  reg   busy_reg = 0;
  reg   overrun_error_reg = 0;
  reg   frame_error_reg = 0;
  reg  [(-1)+DATA_WIDTH:0]  data_reg = 0;
  reg  [18:0]  prescale_reg = 0;
  reg  [3:0]  bit_cnt = 0;
  reg  parity;

  assign output_axis_tdata = output_axis_tdata_reg;
  assign output_axis_tvalid = output_axis_tvalid_reg;
  assign busy = busy_reg;
  assign overrun_error = overrun_error_reg;
  assign frame_error = frame_error_reg;
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            output_axis_tdata_reg <= 0;
            output_axis_tvalid_reg <= 0;
            rxd_reg <= 1;
            prescale_reg <= 0;
            bit_cnt <= 0;
            busy_reg <= 0;
            overrun_error_reg <= 0;
            frame_error_reg <= 0;
            parity <= 1'b0;
          end
        else 
          begin
            rxd_reg <= rxd;
            overrun_error_reg <= 0;
            frame_error_reg <= 0;
            if (output_axis_tready & output_axis_tvalid) 
              begin
                output_axis_tvalid_reg <= 0;
              end
              
            if (prescale_reg > 0) 
              begin
                prescale_reg <= prescale_reg+(-1);
              end
            else if (bit_cnt > 0) 
              begin
                if (bit_cnt > (uart_data_width+(uart_stopbit ? 1<<<1 : 1))) 
                  begin
                    if (~rxd_reg) 
                      begin
                        bit_cnt <= bit_cnt+(-1);
                        prescale_reg <= (-1)+(prescale*(1<<<1**3));
                      end
                    else 
                      begin
                        bit_cnt <= 0;
                        prescale_reg <= 0;
                      end
                  end
                else if (bit_cnt > (uart_stopbit ? 1<<<1 : 1)) 
                  begin
                    bit_cnt <= bit_cnt+(-1);
                    if ((bit_cnt == (uart_stopbit ? 3 : 1<<<1)) && 
                        (uart_stopbit[1] == 1'b1)) prescale_reg <= (1<<<1*prescale)<<<1+(-1);
                    else prescale_reg <= (-1)+(prescale*(1<<<1**3));
                    if ((uart_parity == 2'b01) && 
                        (bit_cnt == (uart_stopbit ? 3 : 1<<<1))) 
                      begin
                        parity <= ~((((rxd_reg & (~parity | parity)) | parity) & ((~parity | (~rxd_reg & ((rxd_reg & (~parity | parity)) | parity))) & parity)) ^ (((((rxd_reg & (~parity | parity)) | parity) & (rxd_reg ^ (rxd_reg & (rxd_reg & parity)))) & ~(((rxd_reg & (~parity | parity)) | parity) & ((rxd_reg & parity) ^ ((rxd_reg & parity) & parity)))) | (~(((rxd_reg & (~parity | parity)) | parity) & (rxd_reg ^ (rxd_reg & (rxd_reg & parity)))) & (((rxd_reg & (~parity | parity)) | parity) & ((rxd_reg & parity) ^ ((rxd_reg & parity) & parity))))));
                      end
                    else if ((uart_parity == 2'b10) && 
                             (bit_cnt == (uart_stopbit ? 3 : 1<<<1))) 
                      begin
                        parity <= (((rxd_reg & (~parity | parity)) | parity) & ((~parity | (~rxd_reg & ((rxd_reg & (~parity | parity)) | parity))) & parity)) ^ (((((rxd_reg & (~parity | parity)) | parity) & (rxd_reg ^ (rxd_reg & (rxd_reg & parity)))) & ~(((rxd_reg & (~parity | parity)) | parity) & ((rxd_reg & parity) ^ ((rxd_reg & parity) & parity)))) | (~(((rxd_reg & (~parity | parity)) | parity) & (rxd_reg ^ (rxd_reg & (rxd_reg & parity)))) & (((rxd_reg & (~parity | parity)) | parity) & ((rxd_reg & parity) ^ ((rxd_reg & parity) & parity)))));
                      end
                    else 
                      begin
                        parity <= (((rxd_reg & (~parity | parity)) | parity) & ((~parity | (~rxd_reg & ((rxd_reg & (~parity | parity)) | parity))) & parity)) ^ (((((rxd_reg & (~parity | parity)) | parity) & (rxd_reg ^ (rxd_reg & (rxd_reg & parity)))) & ~(((rxd_reg & (~parity | parity)) | parity) & ((rxd_reg & parity) ^ ((rxd_reg & parity) & parity)))) | (~(((rxd_reg & (~parity | parity)) | parity) & (rxd_reg ^ (rxd_reg & (rxd_reg & parity)))) & (((rxd_reg & (~parity | parity)) | parity) & ((rxd_reg & parity) ^ ((rxd_reg & parity) & parity)))));
                        data_reg <= {rxd_reg,data_reg[(-1)+DATA_WIDTH:1]};
                      end
                  end
                else if (bit_cnt == 1) 
                  begin
                    bit_cnt <= bit_cnt+(-1);
                    if (
(((parity == 1'b1) && (uart_parity == 2'b00)) || 
((uart_parity != 2'b00) && (parity == 1'b1)) || (uart_parity == 2'b00)) && (rxd_reg == 1'b1)) 
                      begin
                        output_axis_tdata_reg <= data_reg;
                        output_axis_tvalid_reg <= 1;
                        overrun_error_reg <= output_axis_tvalid_reg;
                      end
                    else 
                      begin
                        frame_error_reg <= 1;
                      end
                  end
                  
              end
            else 
              begin
                busy_reg <= 0;
                if (~rxd_reg) 
                  begin
                    prescale_reg <= (0-1<<<1)+(1<<<1*prescale)<<<1;
                    bit_cnt <= uart_data_width+(uart_stopbit ? 3 : 1<<<1);
                    data_reg <= 0;
                    busy_reg <= 1;
                    parity <= 1'b0;
                  end
                  
              end
          end
      end
endmodule

