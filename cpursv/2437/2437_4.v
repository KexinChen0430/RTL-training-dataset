
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
       u = ~((((s0 & b) | (a & ~b)) | a) | (s1 & ((((s0 & b) | (a & ~b)) | a) | (s0 | ~b))));
  wire [3:0] 
       v = ~((((a & s2) & ~b) | s3) & ((((a & s2) & ~b) | b) & a));
  wire [3:0]  w = ((v & ~u) | ~v) & ((~v & u) | v);
  wire [3:0] z;

  assign z[0] = ~(c_ & ~m);
  assign z[1] = ~((c_ | u[0]) & ((u[0] & ~m) | (v[0] & ~m)));
  assign z[2] = ~((v[1] | (((v[1] & u[0]) | u[1]) & ~m)) & ((((v[0] & c_) | ((u[1] | u[0]) & (~m & v[1]))) | (u[1] & ((u[1] | u[0]) & ~m))) & ~m));
  assign z[3] = ~((u[2] & ~m) | ((~m & ((v[2] & u[1]) | ((v[2] & u[0]) & v[1]))) | ((c_ & ~m) & ((v[0] & v[1]) & v[2]))));
  assign g = ~((((v[3] & u[2]) | u[3]) | (((v[2] & u[0]) & v[1]) & v[3])) | (v[2] & (v[3] & u[1])));
  assign p = ~&v;
  wire  g2 = ~(c_ & &v);

  assign co_ = ~g2 | ~g;
  assign f = ((w & ~z) | z) & (~z | (~w & z));
  assign eq = &f;
endmodule

