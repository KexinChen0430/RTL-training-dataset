
module components_dff  #(parameter  WIDTH = 1)
  (input  clk,
   input  [(-1)+WIDTH:0] d,
   output [(-1)+WIDTH:0] q);

  reg  [(-1)+WIDTH:0] contents;

  
  always @(posedge clk)
      begin
        contents <= d;
      end
  assign q = contents;
endmodule

