
module alu_flags  #(parameter  DATA_WIDTH = 32)
  (input  [(0-1)+DATA_WIDTH:0] srcA,
   input  [(0-1)+DATA_WIDTH:0] srcB,
   input  [3:0] aluop,
   output zero,
   output of,
   output uof);

  wire [(0-1)+DATA_WIDTH:0] sum,diff;
  wire carry1,carry2;

  assign {carry1,sum} = srcB+srcA;
  assign {carry2,diff} = (0-srcB)+srcA;
  assign zero = srcA == srcB;
  assign of = (aluop == 4'd5) ? (((((((~srcA[(0-1)+DATA_WIDTH] & sum[(0-1)+DATA_WIDTH]) | ~sum[(0-1)+DATA_WIDTH]) & ((srcB[(0-1)+DATA_WIDTH] & ~sum[(0-1)+DATA_WIDTH]) | ~srcB[(0-1)+DATA_WIDTH])) & (~srcA[(0-1)+DATA_WIDTH] & sum[(0-1)+DATA_WIDTH])) & ~srcB[(0-1)+DATA_WIDTH]) | (sum[(0-1)+DATA_WIDTH] & ((((~srcA[(0-1)+DATA_WIDTH] & ~srcB[(0-1)+DATA_WIDTH]) | (srcB[(0-1)+DATA_WIDTH] & ~sum[(0-1)+DATA_WIDTH])) & (srcA[(0-1)+DATA_WIDTH] | (~srcA[(0-1)+DATA_WIDTH] & ~srcB[(0-1)+DATA_WIDTH]))) & (srcA[(0-1)+DATA_WIDTH] & srcB[(0-1)+DATA_WIDTH])))) | ((((~srcA[(0-1)+DATA_WIDTH] & ~srcB[(0-1)+DATA_WIDTH]) | (srcB[(0-1)+DATA_WIDTH] & ~sum[(0-1)+DATA_WIDTH])) & (srcA[(0-1)+DATA_WIDTH] | (~srcA[(0-1)+DATA_WIDTH] & ~srcB[(0-1)+DATA_WIDTH]))) & (srcA[(0-1)+DATA_WIDTH] & srcB[(0-1)+DATA_WIDTH]))) : 
              (aluop == 4'd6) ? ((((srcB[(0-1)+DATA_WIDTH] & ((~srcA[(0-1)+DATA_WIDTH] & srcB[(0-1)+DATA_WIDTH]) | ~diff[(0-1)+DATA_WIDTH])) & (~srcA[(0-1)+DATA_WIDTH] & diff[(0-1)+DATA_WIDTH])) | ~srcB[(0-1)+DATA_WIDTH]) & ((srcA[(0-1)+DATA_WIDTH] & ((~srcA[(0-1)+DATA_WIDTH] & srcB[(0-1)+DATA_WIDTH]) | ~diff[(0-1)+DATA_WIDTH])) | ((srcB[(0-1)+DATA_WIDTH] & ((~srcA[(0-1)+DATA_WIDTH] & srcB[(0-1)+DATA_WIDTH]) | ~diff[(0-1)+DATA_WIDTH])) & (~srcA[(0-1)+DATA_WIDTH] & diff[(0-1)+DATA_WIDTH])))) : 0;
  assign uof = (aluop == 4'd5) ? carry1 : 
               (aluop == 4'd6) ? carry2 : 0;
endmodule

