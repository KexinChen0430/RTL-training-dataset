
module SmallLpfUnsigned  #(parameter  WIDTH = 8, FILT_BITS = 8)
  (input  clk,
   input  rst,
   input  en,
   input  [WIDTH+(0-1):0] dataIn,
   output [WIDTH+(0-1):0] dataOut);

  reg  [(WIDTH+FILT_BITS)+(0-1):0] filter;

  assign dataOut = filter[(WIDTH+FILT_BITS)+(0-1):FILT_BITS];
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            filter <= 'd0;
          end
        else if (en) 
          begin
            filter <= filter+(dataIn+(0-dataOut));
          end
          
      end
endmodule

