
module components_shiftreg  #(parameter  WIDTH = 8, RESET_VAL = 0)
  (input  clk,
   input  rst,
   input  sh_en,
   input  load,
   input  [(0-1)+WIDTH:0] d,
   input  sh_in,
   output [(0-1)+WIDTH:0] q,
   output sh_out);

  reg  [(0-1)+WIDTH:0] contents;

  
  always @(posedge clk)
      begin
        if (rst == 1'b1) contents <= RESET_VAL;
        else if (load == 1'b1) contents <= d;
        else if (sh_en == 1'b1) contents <= sh_in | contents<<1;
          
      end
  assign q = contents;
  assign sh_out = contents[(0-1)+WIDTH];
endmodule

