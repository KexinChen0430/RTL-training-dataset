
module alu_flags  #(parameter  DATA_WIDTH = 32)
  (input  [(-1)+DATA_WIDTH:0] srcA,
   input  [(-1)+DATA_WIDTH:0] srcB,
   input  [3:0] aluop,
   output zero,
   output of,
   output uof);

  wire [(-1)+DATA_WIDTH:0] sum,diff;
  wire carry1,carry2;

  assign {carry1,sum} = srcB+srcA;
  assign {carry2,diff} = (-srcB)+srcA;
  assign zero = srcA == srcB;
  assign of = (aluop == 4'd5) ? ((~sum[(-1)+DATA_WIDTH] & (srcA[(-1)+DATA_WIDTH] & srcB[(-1)+DATA_WIDTH])) | (((~srcB[(-1)+DATA_WIDTH] & (~sum[(-1)+DATA_WIDTH] & (srcA[(-1)+DATA_WIDTH] & srcB[(-1)+DATA_WIDTH]))) | (~srcB[(-1)+DATA_WIDTH] & ~srcA[(-1)+DATA_WIDTH])) & ((srcB[(-1)+DATA_WIDTH] | sum[(-1)+DATA_WIDTH]) & (sum[(-1)+DATA_WIDTH] | srcA[(-1)+DATA_WIDTH])))) : 
              (aluop == 4'd6) ? (((diff[(-1)+DATA_WIDTH] | (~diff[(-1)+DATA_WIDTH] & ~srcB[(-1)+DATA_WIDTH])) & ((srcA[(-1)+DATA_WIDTH] | (~srcA[(-1)+DATA_WIDTH] & srcB[(-1)+DATA_WIDTH])) & ((~diff[(-1)+DATA_WIDTH] & ~srcB[(-1)+DATA_WIDTH]) | (~srcA[(-1)+DATA_WIDTH] & srcB[(-1)+DATA_WIDTH])))) & (srcA[(-1)+DATA_WIDTH] | diff[(-1)+DATA_WIDTH])) : 0;
  assign uof = (aluop == 4'd5) ? carry1 : 
               (aluop == 4'd6) ? carry2 : 0;
endmodule

