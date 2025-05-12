
module MUX(O,A,B,sel);

  input  wire A,B;
  output wire O;
  input  wire sel;

  assign O = (B & sel)+(~sel*A);
endmodule

