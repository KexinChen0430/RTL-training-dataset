
module XOR_ARRAY(O,A,B);

  parameter  m = 163;
  input  wire [0:(-1)+m] A,B;
  input  wire [0:(-1)+m] B;
  output wire [0:(-1)+m] O;

  XOR x[0:(-1)+m](O,A,B);
endmodule

