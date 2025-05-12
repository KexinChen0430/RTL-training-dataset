
module SmallLpfUnsigned  #(parameter  WIDTH = 8, FILT_BITS = 8)
  (input  clk,
   input  rst,
   input  en,
   input  [(0-1)+WIDTH:0] dataIn,
   output [(0-1)+WIDTH:0] dataOut);

  reg  [(FILT_BITS+WIDTH)+(0-1):0] filter;

  assign dataOut = filter[(FILT_BITS+WIDTH)+(0-1):FILT_BITS];
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            filter <= 'd0;
          end
        else if (en) 
          begin
            filter <= ((-dataOut)+dataIn)+filter;
          end
          
      end
endmodule

