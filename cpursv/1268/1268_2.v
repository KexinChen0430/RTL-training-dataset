
module left_shift(in,out,shift);

  output [15:0] out;
  input  [15:0] in;
  input  [3:0] shift;

  assign out = in*(2**shift);
endmodule

