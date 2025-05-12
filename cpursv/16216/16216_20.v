
module SmallLpf  #(parameter  WIDTH = 8, FILT_BITS = 8)
  (input  clk,
   input  rst,
   input  en,
   input  signed  [(0-1)+WIDTH:0] dataIn,
   output signed  [(0-1)+WIDTH:0] dataOut);

  reg  signed  [WIDTH+(FILT_BITS+(0-1)):0] filter;

  assign dataOut = filter[WIDTH+(FILT_BITS+(0-1)):FILT_BITS];
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            filter <= 'd0;
          end
        else if (en) 
          begin
            filter <= dataIn+(filter+(0-dataOut));
          end
          
      end
endmodule

