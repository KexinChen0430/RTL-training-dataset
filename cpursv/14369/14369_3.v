
module XOR_SINGLE_ARRAY(O,A);

  parameter  m = 163;
  input  wire [0:(-1)+m] A;
  output wire O;

  assign O = ^A;
endmodule

