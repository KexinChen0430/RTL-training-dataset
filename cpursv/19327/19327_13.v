
module SELECT_1_TO_N  #(parameter  SEL_WIDTH = 4, OUTPUT_WIDTH = 16)
  (input  wire [SEL_WIDTH-1:0] Sel,
   input  wire En,
   output wire [(0-1)+OUTPUT_WIDTH:0] O);

  reg  [(0-1)+OUTPUT_WIDTH:0] shift;

  
  always @(*)
      begin
        if (~En) shift = 1;
        else shift = 2**Sel;
      end
  assign O = ~En ? 0 : shift;
endmodule

