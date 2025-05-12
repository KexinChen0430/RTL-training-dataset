
module RARb  #(parameter  n = 8)
  (r,g);

  input  [n+(0-1):0] r;
  output [n+(0-1):0] g;
  wire [n+(0-1):0]  c = {1'b1,~r[n+(0-1):1] & c[n+(0-1):1]};

  assign g = c & r;
endmodule

