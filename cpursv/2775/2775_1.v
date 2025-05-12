
module v0(a,c);

  input  [193:0] a;
  output [193:0] c;

  assign c[1:0] = a[1:0];
  assign c[3:2] = a[131:130];
  assign c[5:4] = a[67:66];
  assign c[7:6] = a[3:2];
  assign c[21:20] = {a[128],a[129]};
endmodule

