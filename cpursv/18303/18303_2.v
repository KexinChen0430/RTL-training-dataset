
module Test2(output [7:0] as);

  wire signed  [7:0] b;
  wire signed  [3:0] c;

  assign c = -1;
  assign b = 3;
  assign as = c+b;
endmodule

