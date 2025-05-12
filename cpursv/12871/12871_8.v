
module SmallLpfUnsigned  #(parameter  WIDTH = 8, FILT_BITS = 8)
  (input  clk,
   input  rst,
   input  en,
   input  [WIDTH-1:0] dataIn,
   output [WIDTH-1:0] dataOut);

  reg  [(WIDTH-1)+FILT_BITS:0] filter;

  assign dataOut = filter[(WIDTH-1)+FILT_BITS:FILT_BITS];
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            filter <= 'd0;
          end
        else if (en) 
          begin
            filter <= (filter+(0-dataOut))+dataIn;
          end
          
      end
endmodule

