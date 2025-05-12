
module wrapper(output [1:0] bout,
               output [31:0] o,
               input  [1:0] bin,
               input  [31:0] i0,
               input  [31:0] i1,
               input  [31:0] i2,
               input  [31:0] i3);

  or u_or[31:0](o[31:0],i0[31:0],i1[31:0],i2[31:0],i3[31:0]);
  buf #1 mybuf[1:0](bout[1:0],bin[1:0]);
endmodule

