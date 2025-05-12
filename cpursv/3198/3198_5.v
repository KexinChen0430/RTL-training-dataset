
module blake2_G(input  wire [63:0] a,
                input  wire [63:0] b,
                input  wire [63:0] c,
                input  wire [63:0] d,
                input  wire [63:0] m0,
                input  wire [63:0] m1,
                output wire [63:0] a_prim,
                output wire [63:0] b_prim,
                output wire [63:0] c_prim,
                output wire [63:0] d_prim);

  wire [63:0]  a0 = b+(m0+a);
  wire [63:0] 
       d0 = ((((a0 & ~d) & d) | (d & ~a0)) & (~d | (~a0 & (d | a0)))) | (a0 & ~d);
  wire [63:0]  d1 = {d0[31:0],d0[63:32]};
  wire [63:0]  c0 = d1+c;
  wire [63:0] 
       b0 = (((b & (~b | ~c0)) & (~b | ~c0)) & ~c0) | ((b & c0) ^ c0);
  wire [63:0]  b1 = {b0[23:0],b0[63:24]};
  wire [63:0]  a1 = a0+(m1+b1);
  wire [63:0]  d2 = a1 ^ ((a1 | ~a1) & d1);
  wire [63:0]  d3 = {d2[15:0],d2[63:16]};
  wire [63:0]  c1 = d3+c0;
  wire [63:0]  b2 = b1 ^ (c1 & (b1 | ~b1));
  wire [63:0]  b3 = {b2[62:0],b2[63]};

  assign a_prim = a1;
  assign b_prim = b3;
  assign c_prim = c1;
  assign d_prim = d3;
endmodule

