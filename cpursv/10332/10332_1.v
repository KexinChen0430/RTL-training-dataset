
module source(out);

  parameter  SIZE = 1;
  output [(0-1)+SIZE:0] out;

  assign out = {SIZE{1'b0}};
endmodule

