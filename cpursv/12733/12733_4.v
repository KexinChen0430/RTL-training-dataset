
module components_dff_en_rst  #(parameter  WIDTH = 1, RESET_VAL = 0)
  (input  clk,
   input  rst,
   input  en,
   input  [WIDTH+(0-1):0] d,
   output [WIDTH+(0-1):0] q);

  reg  [WIDTH+(0-1):0]  contents = RESET_VAL;

  
  always @(posedge clk)
      begin
        if (rst == 1'b1) contents <= RESET_VAL;
        else if (en == 1'b1) contents <= d;
          
      end
  assign q = contents;
endmodule

