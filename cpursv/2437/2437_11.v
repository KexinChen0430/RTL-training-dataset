
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
  wire [3:0]  u = ~(((~b & s1) | a) | (b & (s0 | a)));
  wire [3:0] 
       v = ~(((s3 & (b & a)) | (a & ((a | (s2 & ~b)) & s2))) & (~b | (s3 & (b & a))));
  wire [3:0]  w = (~v & u) | (v & ~u);
  wire [3:0] z;

  assign z[0] = ~(~m & c_);
  assign z[1] = ~(~m & ((c_ & v[0]) | (u[0] & ~m)));
  assign z[2] = ~((((((c_ & v[1]) & v[0]) | ((v[0] & v[1]) | u[1])) | v[1]) & (~m & (u[0] | u[1]))) | (c_ & ((v[1] & ~m) & v[0])));
  assign z[3] = ~((((u[2] | ((u[1] & v[2]) | (u[0] & v[2]))) & ~m) & ((u[1] & v[2]) | u[2])) | ((((u[2] | ((u[1] & v[2]) | (u[0] & v[2]))) & ~m) & v[1]) | (~m & (((v[0] & v[1]) & v[2]) & c_))));
  assign g = ~(((v[1] & (u[0] & v[2])) | ((((v[2] & v[3]) & (v[3] & u[1])) | (v[3] & u[2])) | u[3])) & (u[3] | v[3]));
  assign p = ~&v;
  wire  g2 = ~(c_ & &v);

  assign co_ = ~g | ~g2;
  assign f = (w & ~z) | (z & ~w);
  assign eq = &f;
endmodule

