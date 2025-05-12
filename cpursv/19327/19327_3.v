
module SELECT_1_TO_N  #(parameter  SEL_WIDTH = 4, OUTPUT_WIDTH = 16)
  (input  wire [(0-1)+SEL_WIDTH:0] Sel,
   input  wire En,
   output wire [OUTPUT_WIDTH-1:0] O);

  reg  [OUTPUT_WIDTH-1:0] shift;

  
  always @(*)
      begin
        if (~En) shift = 1;
        else shift = 1<<Sel;
      end
  assign O = ~En ? 0 : shift;
endmodule

