
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
  wire [3:0]  u = ~((a | ((b & s0) | s1)) & (a | (s0 | ~b)));
  wire [3:0]  v = ~(a & ((b & s3) | (s2 & ~b)));
  wire [3:0]  w = v ^ u;
  wire [3:0] z;

  assign z[0] = ~(~m & c_);
  assign z[1] = ~((~m & (v[0] & c_)) | (u[0] & ~m));
  assign z[2] = ~((~m & ((u[1] | ((~m & (v[0] & c_)) & (v[2] & v[1]))) | v[1])) & ((u[1] | u[0]) | ((v[0] & c_) & v[1])));
  assign z[3] = ~(((~m & (((u[0] & v[2]) & v[1]) | u[2])) | ((~m & (v[0] & c_)) & (v[2] & v[1]))) | (u[1] & (v[2] & ~m)));
  assign g = ~((u[3] | (v[3] & (v[2] & u[1]))) | (((v[2] & v[3]) & ((u[0] & v[2]) & v[1])) | (v[3] & u[2])));
  assign p = ~&v;
  wire  g2 = ~(c_ & &v);

  assign co_ = ~g2 | ~g;
  assign f = (((~z | (z & ~w)) & w) & ~z) | (z & ~w);
  assign eq = &f;
endmodule

