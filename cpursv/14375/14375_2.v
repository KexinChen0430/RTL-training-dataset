
module XOR_ARRAY(O,A,B);

  parameter  m = 163;
  input  wire [0:m+(-1)] A,B;
  input  wire [0:m+(-1)] B;
  output wire [0:m+(-1)] O;

  XOR x[0:m+(-1)](O,A,B);
endmodule

