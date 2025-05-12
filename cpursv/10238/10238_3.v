
module zzadd32v(z,a,b,cin,add32);

  parameter  N = 31;
  input  [N:0] a;
  wire cout15;
  wire cin16;
  wire cout31;

  assign cin16 = add32 ? cout15 : cin;
  assign {cout15,z[15:0]} = a[15:0]+(cin+b[15:0]);
  assign {cout31,z[N:16]} = (b[N:16]+cin16)+a[N:16];
endmodule

