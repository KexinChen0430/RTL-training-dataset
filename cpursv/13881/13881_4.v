
module components_shiftreg  #(parameter  WIDTH = 8, RESET_VAL = 0)
  (input  clk,
   input  rst,
   input  sh_en,
   input  load,
   input  [(-1)+WIDTH:0] d,
   input  sh_in,
   output [(-1)+WIDTH:0] q,
   output sh_out);

  reg  [(-1)+WIDTH:0] contents;

  
  always @(posedge clk)
      begin
        if (rst == 1'b1) contents <= RESET_VAL;
        else if (load == 1'b1) contents <= d;
        else if (sh_en == 1'b1) contents <= contents<<1 | sh_in;
          
      end
  assign q = contents;
  assign sh_out = contents[(-1)+WIDTH];
endmodule

