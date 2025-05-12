
module mul(q,a,b);

  input  a,b;
  output [1:0] q;

  assign q = {1'b0,b}*{1'b0,a};
endmodule

