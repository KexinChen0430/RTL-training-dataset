
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
       u = ~(((a | (s0 | ((a & s2) & (~b & a)))) & ((((a & s2) & (~b & a)) | b) | a)) | (~b & s1));
  wire [3:0]  v = ~(((a & s2) & (~b & a)) | ((s3 & b) & a));
  wire [3:0]  w = v ^ u;
  wire [3:0] z;

  assign z[0] = ~(~m & c_);
  assign z[1] = ~((c_ | u[0]) & ((u[0] | v[0]) & ~m));
  assign z[2] = ~(((((u[0] | u[1]) & v[1]) & ~m) | (v[1] & (c_ & (v[0] & ~m)))) | (~m & u[1]));
  assign z[3] = ~((((~m & c_) & ((v[1] & v[0]) & v[2])) | (u[1] & (~m & (v[2] | u[2])))) | ((~m & u[2]) | ((v[1] & v[2]) & (u[0] & ~m))));
  assign g = ~((((u[0] & v[2]) & (v[3] & (v[1] & v[3]))) | (v[3] & ((((v[2] & (u[0] & v[1])) | (v[3] & u[2])) | v[3]) & (v[2] & u[1])))) | ((((u[0] & v[2]) & (v[3] & (v[1] & v[3]))) | (v[3] & u[2])) | (u[3] | ((u[0] & v[2]) & (v[3] & (v[1] & v[3]))))));
  assign p = ~&v;
  wire  g2 = ~(&v & c_);

  assign co_ = ~g | ~g2;
  assign f = ((~w & z) | w) & (~w | ~z);
  assign eq = &f;
endmodule

