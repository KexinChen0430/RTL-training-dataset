
module XOR(O,A,B);

  input  wire A,B;
  output wire O;

  assign O = (B*~A)+(A*~B);
endmodule

