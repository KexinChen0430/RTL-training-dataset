
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
       u = ~(((a & (~b & s2)) | (b & ((((a & (~b & s2)) | s0) | ((s3 & a) & b)) | a))) | ((s1 & ~b) | a));
  wire [3:0] 
       v = ~((((s3 & a) & b) | s2) & ((~b & a) | ((s3 & a) & b)));
  wire [3:0]  w = (~v & u) | (~u & v);
  wire [3:0] z;

  assign z[0] = ~(c_ & ~m);
  assign z[1] = ~((v[0] | (~m & u[0])) & (((~m & u[0]) | c_) & ~m));
  assign z[2] = ~((((~m & u[1]) | (~m & u[0])) & (v[1] | ((v[1] & v[0]) | u[1]))) | ((c_ & ~m) & (v[1] & v[0])));
  assign z[3] = ~(((~m & (v[1] & ((v[0] & c_) & v[2]))) | (~m & u[2])) | (((u[0] & v[1]) & (v[2] & ~m)) | (~m & (v[2] & u[1]))));
  assign g = ~((v[3] & ((v[3] & (v[2] & u[1])) | ((u[0] & v[1]) & v[2]))) | ((u[3] | (v[3] & (v[2] & u[1]))) | (v[3] & u[2])));
  assign p = ~&v;
  wire  g2 = ~(c_ & &v);

  assign co_ = ~g | ~g2;
  assign f = z ^ w;
  assign eq = &f;
endmodule

