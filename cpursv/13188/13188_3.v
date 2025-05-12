
module mux(a,sel,b);

  parameter  Value = 0;
  parameter  Width = 1;
  input  [Width+(0-1):0] a;
  input  sel;
  output [Width+(0-1):0] b;

  assign b = sel ? Value : a;
endmodule

