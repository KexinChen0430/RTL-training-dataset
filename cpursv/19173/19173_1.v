
module Test(out,clk,a,b);

  input  clk;
  input  [7:0] a;
  input  [7:0] b;
  output reg [63:0] out;

  and u0[7:0](out[7:0],a[7:0],b[7:0]);
  and u1[7:0](out[15:8],a[0],b[7:0]);
  and u2[7:0](out[23:16],a[0],b[0]);
  nand u3[7:0](out[31:24],a[0],b[7:0]);
  or u4[7:0](out[39:32],a[0],b[7:0]);
  nor u5[7:0](out[47:40],a[0],b[7:0]);
  xor u6[7:0](out[55:48],a[0],b[7:0]);
  xnor u7[7:0](out[63:56],a[0],b[7:0]);
endmodule

