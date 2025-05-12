
module v2(a,c);

  input  [193:0] a;
  output [193:0] c;

  assign c[1:0] = a[187:186];
  assign c[3:2] = 0;
  assign c[5:4] = 0;
  assign c[7:6] = a[189:188];
  assign c[9:8] = 0;
  assign c[11:10] = 0;
  assign c[13:12] = a[191:190];
  assign c[15:14] = 0;
  assign c[17:16] = 0;
  assign c[19:18] = a[185:184];
  assign c[21:20] = 0;
  assign c[23:22] = 0;
  assign c[25:24] = 0;
  assign c[27:26] = a[123:122];
  assign c[29:28] = 0;
  assign c[31:30] = 0;
  assign c[33:32] = a[141:140];
  assign c[35:34] = 0;
  assign c[37:36] = 0;
  assign c[39:38] = a[143:142];
endmodule

