
module components_dff  #(parameter  WIDTH = 1)
  (input  clk,
   input  [WIDTH+(0-1):0] d,
   output [WIDTH+(0-1):0] q);

  reg  [WIDTH+(0-1):0] contents;

  
  always @(posedge clk)
      begin
        contents <= d;
      end
  assign q = contents;
endmodule

