
module substruct(input  [31:0] a,
                 input  [31:0] b,
                 output [31:0] c);

  assign c = 1+(~b+a);
endmodule

