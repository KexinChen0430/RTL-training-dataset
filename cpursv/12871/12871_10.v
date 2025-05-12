
module SmallLpfUnsigned  #(parameter  WIDTH = 8, FILT_BITS = 8)
  (input  clk,
   input  rst,
   input  en,
   input  [WIDTH+(0-1):0] dataIn,
   output [WIDTH+(0-1):0] dataOut);

  reg  [(WIDTH+(0-1))+FILT_BITS:0] filter;

  assign dataOut = filter[(WIDTH+(0-1))+FILT_BITS:FILT_BITS];
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            filter <= 'd0;
          end
        else if (en) 
          begin
            filter <= (dataIn+filter)+(-dataOut);
          end
          
      end
endmodule

