
module SmallLpf  #(parameter  WIDTH = 8, FILT_BITS = 8)
  (input  clk,
   input  rst,
   input  en,
   input  signed  [WIDTH-1:0] dataIn,
   output signed  [WIDTH-1:0] dataOut);

  reg  signed  [((-1)+FILT_BITS)+WIDTH:0] filter;

  assign dataOut = filter[((-1)+FILT_BITS)+WIDTH:FILT_BITS];
  
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

