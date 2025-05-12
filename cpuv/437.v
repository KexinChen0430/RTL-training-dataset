module mmu_in_iram (
  input [31:0] from_pc,  
  output [31:0] to_iram  
);
  wire \from_pc[31] , \from_pc[30] , \from_pc[29] , \from_pc[28] ,
       \from_pc[27] , \from_pc[26] , \from_pc[25] , \from_pc[24] ,
       \from_pc[23] , \from_pc[22] , \from_pc[21] , \from_pc[20] ,
       \from_pc[19] , \from_pc[18] , \from_pc[17] , \from_pc[16] ,
       \from_pc[15] , \from_pc[14] , \from_pc[13] , \from_pc[12] ,
       \from_pc[11] , \from_pc[10] , \from_pc[9] , \from_pc[8] ,
       \from_pc[7] , \from_pc[6] , \from_pc[5] , \from_pc[4] , \from_pc[3] ,
       \from_pc[2] ;
  assign to_iram[31] = 1'b0; 
  assign to_iram[30] = 1'b0; 
  assign to_iram[29] = \from_pc[31] ;
  assign \from_pc[31]  = from_pc[31];
  assign to_iram[0] = \from_pc[2] ;
  assign \from_pc[2]  = from_pc[2];
endmodule