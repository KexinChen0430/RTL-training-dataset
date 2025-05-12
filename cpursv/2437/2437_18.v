
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
  wire [3:0]  u = ~(a | ((~b & s1) | (s0 & b)));
  wire [3:0] 
       v = ~(((~b | ((((s2 & ~b) | a) & s3) & a)) & (s2 | (s3 & ((a & b) & a)))) & a);
  wire [3:0]  w = (~u & v) | (~v & u);
  wire [3:0] z;

  assign z[0] = ~(c_ & ~m);
  assign z[1] = ~((~m & u[0]) | (c_ & (~m & v[0])));
  assign z[2] = ~((v[1] | (u[1] | ((~m & v[0]) & (v[1] & c_)))) & (((u[1] | (v[1] & v[0])) | u[0]) & (((((v[1] & (u[0] | u[1])) | c_) | (v[1] | (u[1] | ((~m & v[0]) & (v[1] & c_))))) & ~m) & ((u[0] | u[1]) | c_))));
  assign z[3] = ~(((((((v[1] & v[0]) & v[2]) & c_) | ((u[2] | (v[1] & (v[2] & u[0]))) | ((v[1] & v[0]) & v[2]))) | v[2]) & ~m) & (((v[1] & u[0]) | (u[2] | (u[1] & (((((v[1] & v[0]) & v[2]) & c_) | ((u[2] | (v[1] & (v[2] & u[0]))) | ((v[1] & v[0]) & v[2]))) | v[2])))) | (((v[1] & v[0]) & v[2]) & c_)));
  assign g = ~((((v[3] & u[2]) | u[3]) | ((u[1] | (v[3] & u[2])) & ((((v[3] & u[2]) | (v[1] & (v[2] & u[0]))) & v[3]) | (v[3] & v[2])))) | ((v[1] & (u[0] & v[3])) & v[2]));
  assign p = ~&v;
  wire  g2 = ~(&v & c_);

  assign co_ = ~g | ~g2;
  assign f = (~z & w) | (~w & z);
  assign eq = &f;
endmodule

