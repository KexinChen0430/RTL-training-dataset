
module MUX(O,A,B,sel);

  input  wire A,B;
  output wire O;
  input  wire sel;

  assign O = (A*~sel)+(B & sel);
endmodule

