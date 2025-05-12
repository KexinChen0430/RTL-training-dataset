
module exchange(A,B,C,ABn);

  input  [(0-1)+2:0] A;
  input  [(0-1)+2:0] B;
  output [(0-1)+2:0] C;
  wire [(0-1)+2:0] C;
  input  ABn;

  assign C = (ABn == 1'b1) ? A : B;
endmodule

