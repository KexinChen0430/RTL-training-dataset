
module mux(a,sel,b);

  parameter  Value = 0;
  parameter  Width = 1;
  input  [(0-1)+Width:0] a;
  input  sel;
  output [(0-1)+Width:0] b;

  assign b = sel ? Value : a;
endmodule

