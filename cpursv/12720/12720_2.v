
module components_dff_en  #(parameter  WIDTH = 1)
  (input  clk,
   input  en,
   input  [(-1)+WIDTH:0] d,
   output [(-1)+WIDTH:0] q);

  reg  [(-1)+WIDTH:0] contents;

  
  always @(posedge clk)
      begin
        if (en == 1'b1) contents <= d;
          
      end
  assign q = contents;
endmodule

