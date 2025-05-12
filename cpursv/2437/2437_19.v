
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
       u = ~(((a & (s2 & ~b)) | (b & (a | (s0 | (a & (s2 & ~b)))))) | (((a & (s2 & ~b)) | (~b & s1)) | a));
  wire [3:0] 
       v = ~(a & (((a & (s2 & ~b)) | b) & (s3 | (a & (s2 & ~b)))));
  wire [3:0]  w = (v & ~u) | (u & ~v);
  wire [3:0] z;

  assign z[0] = ~(c_ & ~m);
  assign z[1] = ~((((u[0] & ~m) | c_) & ~m) & ((u[0] & ~m) | v[0]));
  assign z[2] = ~((u[1] | (c_ | (u[0] & v[1]))) & ((v[1] | (u[1] | (v[1] & v[0]))) & (~m & ((u[1] | (v[1] & v[0])) | (u[1] | u[0])))));
  assign z[3] = ~((((~m & (v[2] | ((v[2] & u[0]) | u[2]))) & u[2]) | (v[2] & (u[0] & (v[1] & ~m)))) | (((v[2] & v[1]) & (~m & (v[0] & c_))) | ((v[2] & ~m) & u[1])));
  assign g = ~(((u[3] | ((u[0] & v[1]) & ((v[2] & (v[3] | (v[1] & (v[2] & u[0])))) & v[3]))) | (v[3] & ((v[2] & u[1]) & (v[3] | (v[1] & (v[2] & u[0])))))) | (((u[0] & v[1]) & ((v[2] & (v[3] | (v[1] & (v[2] & u[0])))) & v[3])) | (v[3] & u[2])));
  assign p = ~&v;
  wire  g2 = ~(&v & c_);

  assign co_ = ~g | ~g2;
  assign f = (~w & z) | (~z & w);
  assign eq = &f;
endmodule

