
module SmallLpf  #(parameter  WIDTH = 8, FILT_BITS = 8)
  (input  clk,
   input  rst,
   input  en,
   input  signed  [(-1)+WIDTH:0] dataIn,
   output signed  [(-1)+WIDTH:0] dataOut);

  reg  signed  [FILT_BITS+((-1)+WIDTH):0] filter;

  assign dataOut = filter[FILT_BITS+((-1)+WIDTH):FILT_BITS];
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            filter <= 'd0;
          end
        else if (en) 
          begin
            filter <= (0-dataOut)+(dataIn+filter);
          end
          
      end
endmodule

