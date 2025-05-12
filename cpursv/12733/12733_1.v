
module components_dff_en_rst  #(parameter  WIDTH = 1, RESET_VAL = 0)
  (input  clk,
   input  rst,
   input  en,
   input  [(0-1)+WIDTH:0] d,
   output [(0-1)+WIDTH:0] q);

  reg  [(0-1)+WIDTH:0]  contents = RESET_VAL;

  
  always @(posedge clk)
      begin
        if (rst == 1'b1) contents <= RESET_VAL;
        else if (en == 1'b1) contents <= d;
          
      end
  assign q = contents;
endmodule

