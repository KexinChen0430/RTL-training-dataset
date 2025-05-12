
module RARb  #(parameter  n = 8)
  (r,g);

  input  [(-1)+n:0] r;
  output [(-1)+n:0] g;
  wire [(-1)+n:0]  c = {1'b1,c[(-1)+n:1] & ~r[(-1)+n:1]};

  assign g = c & r;
endmodule

