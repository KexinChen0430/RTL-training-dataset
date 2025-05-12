
module util_delay  #(parameter  DATA_WIDTH = 1, DELAY_CYCLES = 1)
  (input  clk,
   input  reset,
   input  din,
   output [(-1)+DATA_WIDTH:0] dout);

  reg  [(-1)+DATA_WIDTH:0] dbuf[0:(-1)+DELAY_CYCLES];

  
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
      for (i = 1; i < DELAY_CYCLES; i = i+1)
          begin : register_pipe
            
            always @(posedge clk)
                begin
                  if (reset) 
                    begin
                      dbuf[i] <= 0;
                    end
                  else 
                    begin
                      dbuf[i] <= dbuf[(-1)+i];
                    end
                end
          end
  endgenerate

  assign dout = dbuf[(-1)+DELAY_CYCLES];
endmodule

