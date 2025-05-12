
module util_delay  #(parameter  DATA_WIDTH = 1, DELAY_CYCLES = 1)
  (input  clk,
   input  reset,
   input  din,
   output [(-1)+DATA_WIDTH:0] dout);

  reg  [(-1)+DATA_WIDTH:0] dbuf[0:DELAY_CYCLES-1];

  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            dbuf[0] <= 0;
          end
        else 
          begin
            dbuf[0] <= din;
          end
      end
  
  generate
      genvar i;
      for (i = 1; i < DELAY_CYCLES; i = 1+i)
          begin : register_pipe
            
            always @(posedge clk)
                begin
                  if (reset) 
                    begin
                      dbuf[i] <= 0;
                    end
                  else 
                    begin
                      dbuf[i] <= dbuf[i-1];
                    end
                end
          end
  endgenerate

  assign dout = dbuf[DELAY_CYCLES-1];
endmodule

