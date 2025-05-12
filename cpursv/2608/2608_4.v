
module RARb  #(parameter  n = 8)
  (r,g);

  input  [(0-1)+n:0] r;
  output [(0-1)+n:0] g;
  wire [(0-1)+n:0]  c = {1'b1,~r[(0-1)+n:1] & c[(0-1)+n:1]};

  assign g = c & r;
endmodule

