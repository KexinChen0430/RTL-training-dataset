
module test04(a,y);

  input  a;
  output [1:0] y;

  assign y = ~((-1'b0)+a);
endmodule

