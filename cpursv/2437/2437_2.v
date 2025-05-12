
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
       u = ~((((b & (a | (s0 | (~b & (s2 & a))))) | a) | ~b) & (((s0 & (((~b & (s2 & a)) | b) | a)) | (~b & (s2 & a))) | (a | ((~b & (s2 & a)) | s1))));
  wire [3:0] 
       v = ~((((b & s3) | a) & ((~b & s2) | (b & s3))) & a);
  wire [3:0]  w = v ^ u;
  wire [3:0] z;

  assign z[0] = ~(c_ & ~m);
  assign z[1] = ~(~m & (u[0] | (v[0] & c_)));
  assign z[2] = ~((~m & (v[1] & u[0])) | (((c_ & (v[0] & v[1])) | u[1]) & ~m));
  assign z[3] = ~(((u[0] | ((v[1] & v[2]) & (v[0] & c_))) & ((v[2] & ~m) & v[1])) | ((u[2] | (v[2] & u[1])) & ~m));
  assign g = ~((u[3] | (v[3] & ((v[3] & u[2]) | (v[2] & u[1])))) | (v[3] & (v[2] & ((v[3] & (v[1] & u[0])) | (v[2] & u[1])))));
  assign p = ~&v;
  wire  g2 = ~(&v & c_);

  assign co_ = ~g2 | ~g;
  assign f = w ^ z;
  assign eq = &f;
endmodule

