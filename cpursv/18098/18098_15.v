
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

            assign a0 = x[(((i*4)+1)*8)-1:(i*4)*8];
            assign a1 = x[((1<<1+(i*4))*8)-1:((i*4)+1)*8];
            assign a2 = x[(8*(3+(i*4)))-1:(1<<1+(i*4))*8];
            assign a3 = x[(0-1)+(8*(4+(i*4))):8*(3+(i*4))];
            assign temp = a3 ^ ((~(((a0 | ~a0) & ((a0 | ~a0) & a0)) ^ ((a0 | ~a0) & ((a0 | ~a0) & a1))) & a2) | (((a0 | ~a0) & ((((~a2 & ~a0) & a1) | (~(((a0 | ~a0) & ((a0 | ~a0) & a0)) ^ ((a0 | ~a0) & ((a0 | ~a0) & a1))) | (a0 & (~a1 & ~a2)))) & ((((~a2 & ~a0) & a1) | (~(((a0 | ~a0) & ((a0 | ~a0) & a0)) ^ ((a0 | ~a0) & ((a0 | ~a0) & a1))) | (a0 & (~a1 & ~a2)))) & (a0 & ~a2)))) ^ ((a0 | ~a0) & ((((~a2 & ~a0) & a1) | (~(((a0 | ~a0) & ((a0 | ~a0) & a0)) ^ ((a0 | ~a0) & ((a0 | ~a0) & a1))) | (a0 & (~a1 & ~a2)))) & ((((~a2 & ~a0) & a1) | (~(((a0 | ~a0) & ((a0 | ~a0) & a0)) ^ ((a0 | ~a0) & ((a0 | ~a0) & a1))) | (a0 & (~a1 & ~a2)))) & (~a2 & a1))))));
            xtime xtime_0(c0,
                          ((a0 | ~a0) & ((a0 | ~a0) & a0)) ^ ((a0 | ~a0) & ((a0 | ~a0) & a1)));
            xtime xtime_1(c1,
                          ((~a2 & a1) | ~a1) & ((~a2 | a2) & (a2 | a1)));
            xtime xtime_2(c2,(a3 & ~a2) | (~a3 & a2));
            xtime xtime_3(c3,
                          (((~a0 | ~a3) & a3) & ~a0) | (((~a0 | ~a3) & ~a3) & a0));
            assign b0 = ((a0 & ~c0) ^ (temp & ~c0)) | (~(a0 ^ temp) & c0);
            assign b1 = (((~a1 | a1) & a1) ^ ((~a1 | a1) & temp)) ^ c1;
            assign b2 = (((a2 & (~(~c2 & temp) & ~c2)) | (~((((~a2 | ~temp) & ~a2) & temp) | (~temp & a2)) | ((~(a2 & ~c2) & ~c2) & temp))) & ((~a2 | ~temp) | ((((a2 & (~(~c2 & temp) & ~c2)) | (~((((~a2 | ~temp) & ~a2) & temp) | (~temp & a2)) | ((~(a2 & ~c2) & ~c2) & temp))) & ~((((~a2 | ~temp) & ~a2) & temp) | (~temp & a2))) & c2))) & (((((~a2 | ~temp) & ~a2) & temp) | ((((a2 & (~(~c2 & temp) & ~c2)) | (~((((~a2 | ~temp) & ~a2) & temp) | (~temp & a2)) | ((~(a2 & ~c2) & ~c2) & temp))) & ~((((~a2 | ~temp) & ~a2) & temp) | (~temp & a2))) & c2)) | a2);
            assign b3 = (((~((~a3 | ~temp) & ((a3 | temp) & (temp | ~temp))) | (~a3 | a3)) & ((~a3 | ~temp) & ((a3 | temp) & (temp | ~temp)))) & ~((~((~a3 | ~temp) & ((a3 | temp) & (temp | ~temp))) | (~a3 | a3)) & c3)) | (~((~((~a3 | ~temp) & ((a3 | temp) & (temp | ~temp))) | (~a3 | a3)) & ((~a3 | ~temp) & ((a3 | temp) & (temp | ~temp)))) & ((~((~a3 | ~temp) & ((a3 | temp) & (temp | ~temp))) | (~a3 | a3)) & c3));
            assign z[(((i*4)+1)*8)-1:(i*4)*8] = b0;
            assign z[((1<<1+(i*4))*8)-1:((i*4)+1)*8] = b1;
            assign z[(8*(3+(i*4)))-1:(1<<1+(i*4))*8] = b2;
            assign z[(0-1)+(8*(4+(i*4))):8*(3+(i*4))] = b3;
          end
  endgenerate

endmodule

