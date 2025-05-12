
module SmallLpf  #(parameter  WIDTH = 8, FILT_BITS = 8)
  (input  clk,
   input  rst,
   input  en,
   input  signed  [WIDTH-1:0] dataIn,
   output signed  [WIDTH-1:0] dataOut);

  reg  signed  [(0-1)+(WIDTH+FILT_BITS):0] filter;

  assign dataOut = filter[(0-1)+(WIDTH+FILT_BITS):FILT_BITS];
  
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

