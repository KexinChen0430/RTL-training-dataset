
module exchange(A,B,C,ABn);

  input  [1<<1-1:0] A;
  input  [1<<1-1:0] B;
  output [1<<1-1:0] C;
  wire [1<<1-1:0] C;
  input  ABn;

  assign C = (ABn == 1'b1) ? A : B;
endmodule

