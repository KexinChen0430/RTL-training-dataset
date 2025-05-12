
module MixColumns(x,z);

  input  [127:0] x;
  output [127:0] z;

  
  generate
      genvar i;
      for (i = 0; i < 4; i = 1+i)
          begin : gen_loop_enc
            wire [7:0] a0,a1,a2,a3,temp;

            wire [7:0] b0,b1,b2,b3;

            wire [7:0] c0,c1,c2,c3;

            assign a0 = x[((1+(i*4))*8)+(-1):(i*8)*4];
            assign a1 = x[(8*(1<<1+(i*4)))+(-1):(1+(i*4))*8];
            assign a2 = x[(((i*4)+3)*8)-1:8*(1<<1+(i*4))];
            assign a3 = x[(-1)+(((i*4)+4)*8):((i*4)+3)*8];
            assign temp = (((~(a2 & ~a3) & ((a0 | ~a0) & (~a3 & a0))) ^ (~(a2 & ~a3) & ((a0 | ~a0) & (a1 & ~a3)))) | (a3 | (~((~a3 & a0) ^ (a1 & ~a3)) & (a2 & ~a3)))) & ((~((~a3 & a0) ^ (a1 & ~a3)) & (a2 & ~a3)) | ((~(((((a0 | ~a0) & ((a0 | ~a0) & a1)) ^ ((a0 | ~a0) & ((a0 | ~a0) & a0))) | (~(((a0 | ~a0) & ((a0 | ~a0) & a1)) ^ ((a0 | ~a0) & ((a0 | ~a0) & a0))) & a2)) & (((a1 & ~a0) & ~a2) | ((a0 & (~a1 & ~a2)) | ~(((a0 | ~a0) & ((a0 | ~a0) & a1)) ^ ((a0 | ~a0) & ((a0 | ~a0) & a0)))))) | (~(a2 & ~a3) & (~a1 & (~a3 & a0)))) | ((~(a2 & ~a3) & (a1 & ~a0)) & ~a3)));
            xtime xtime_0(c0,
                          ((a0 | ~a0) & ((a0 | ~a0) & a1)) ^ ((a0 | ~a0) & ((a0 | ~a0) & a0)));
            xtime xtime_1(c1,a2 ^ a1);
            xtime xtime_2(c2,(a2 & ~a3) | ((~a2 | ~a3) & a3));
            xtime xtime_3(c3,
                          ((a3 | a0) & (a0 | ~a0)) & ((a3 & ~a0) | ~a3));
            assign b0 = ((~a0 & temp) | (~temp & a0)) ^ c0;
            assign b1 = (~c1 | ~(((temp | (a1 & ~temp)) & ~a1) | (a1 & ~temp))) & ((~c1 & (~(~c1 & temp) & a1)) | (c1 | (~(~c1 & a1) & (~c1 & temp))));
            assign b2 = ((((~temp | ~a2) & ~a2) & temp) | ((~temp | ~a2) & a2)) ^ c2;
            assign b3 = (((~(~c3 & temp) & a3) & ~c3) | ((~c3 & (~(a3 & ~c3) & temp)) | c3)) & (~(temp ^ a3) | ~c3);
            assign z[((1+(i*4))*8)+(-1):(i*8)*4] = b0;
            assign z[(8*(1<<1+(i*4)))+(-1):(1+(i*4))*8] = b1;
            assign z[(((i*4)+3)*8)-1:8*(1<<1+(i*4))] = b2;
            assign z[(-1)+(((i*4)+4)*8):((i*4)+3)*8] = b3;
          end
  endgenerate

endmodule

