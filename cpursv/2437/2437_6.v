
module alu181(input  [3:0] a,b,
              input  m,
              input  c_,
              input  [3:0] s,
              output [3:0] f,
              output g,p,
              output co_,
              output eq);

  wire [3:0]  s0 = {4{s[0]}};
  wire [3:0]  s1 = {4{s[1]}};
  wire [3:0]  s2 = {4{s[2]}};
  wire [3:0]  s3 = {4{s[3]}};
  wire [3:0] 
       u = ~((((a | b) & s0) | ((a & s2) & (a & ~b))) | (((~b & s1) | (a & s2)) | a));
  wire [3:0] 
       v = ~(a & ((((b & s3) | (a & s2)) | a) & ((b & s3) | (s2 & ~b))));
  wire [3:0]  w = (~v & u) | (v & (~u | ~v));
  wire [3:0] z;

  assign z[0] = ~(~m & c_);
  assign z[1] = ~((c_ & (v[0] & ~m)) | (u[0] & ~m));
  assign z[2] = ~((((~m & v[1]) & (v[0] & c_)) | ((~m & (u[0] | u[1])) & v[1])) | (u[1] & ~m));
  assign z[3] = ~((u[2] & ~m) | (((~m & (v[1] & v[2])) & (u[0] | (c_ & (v[1] & (v[2] & v[0]))))) | (v[2] & (u[1] & ~m))));
  assign g = ~((v[2] & ((v[3] & u[1]) & v[3])) | ((((v[3] & v[2]) | ((u[2] & ((v[1] & (v[2] & u[0])) | v[3])) & v[3])) & ((v[1] & u[0]) | ((u[2] & ((v[1] & (v[2] & u[0])) | v[3])) & v[3]))) | (((v[2] & (v[3] & u[0])) & v[1]) | u[3])));
  assign p = ~&v;
  wire  g2 = ~(c_ & &v);

  assign co_ = ~g2 | ~g;
  assign f = z ^ w;
  assign eq = &f;
endmodule

