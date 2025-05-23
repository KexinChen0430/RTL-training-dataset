
module mmu_in_iram(from_pc,to_iram);

  input  [31:0] from_pc;
  output [31:0] to_iram;
  wire 
      \from_pc[31],
      \from_pc[30],
      \from_pc[29],
      \from_pc[28],
      \from_pc[27],
      \from_pc[26],
      \from_pc[25],
      \from_pc[24],
      \from_pc[23],
      \from_pc[22],
      \from_pc[21],
      \from_pc[20],
      \from_pc[19],
      \from_pc[18],
      \from_pc[17],
      \from_pc[16],
      \from_pc[15],
      \from_pc[14],
      \from_pc[13],
      \from_pc[12],
      \from_pc[11],
      \from_pc[10],
      \from_pc[9] ,
      \from_pc[8] ,
      \from_pc[7] ,
      \from_pc[6] ,
      \from_pc[5] ,
      \from_pc[4] ,
      \from_pc[3] ,
      \from_pc[2] ;

  assign to_iram[30] = 1'b0;
  assign to_iram[31] = 1'b0;
  assign to_iram[29] = \from_pc[31];
  assign \from_pc[31] = from_pc[31];
  assign to_iram[28] = \from_pc[30];
  assign \from_pc[30] = from_pc[30];
  assign to_iram[27] = \from_pc[29];
  assign \from_pc[29] = from_pc[29];
  assign to_iram[26] = \from_pc[28];
  assign \from_pc[28] = from_pc[28];
  assign to_iram[25] = \from_pc[27];
  assign \from_pc[27] = from_pc[27];
  assign to_iram[24] = \from_pc[26];
  assign \from_pc[26] = from_pc[26];
  assign to_iram[23] = \from_pc[25];
  assign \from_pc[25] = from_pc[25];
  assign to_iram[22] = \from_pc[24];
  assign \from_pc[24] = from_pc[24];
  assign to_iram[21] = \from_pc[23];
  assign \from_pc[23] = from_pc[23];
  assign to_iram[20] = \from_pc[22];
  assign \from_pc[22] = from_pc[22];
  assign to_iram[19] = \from_pc[21];
  assign \from_pc[21] = from_pc[21];
  assign to_iram[18] = \from_pc[20];
  assign \from_pc[20] = from_pc[20];
  assign to_iram[17] = \from_pc[19];
  assign \from_pc[19] = from_pc[19];
  assign to_iram[16] = \from_pc[18];
  assign \from_pc[18] = from_pc[18];
  assign to_iram[15] = \from_pc[17];
  assign \from_pc[17] = from_pc[17];
  assign to_iram[14] = \from_pc[16];
  assign \from_pc[16] = from_pc[16];
  assign to_iram[13] = \from_pc[15];
  assign \from_pc[15] = from_pc[15];
  assign to_iram[12] = \from_pc[14];
  assign \from_pc[14] = from_pc[14];
  assign to_iram[11] = \from_pc[13];
  assign \from_pc[13] = from_pc[13];
  assign to_iram[10] = \from_pc[12];
  assign \from_pc[12] = from_pc[12];
  assign to_iram[9] = \from_pc[11];
  assign \from_pc[11] = from_pc[11];
  assign to_iram[8] = \from_pc[10];
  assign \from_pc[10] = from_pc[10];
  assign to_iram[7] = \from_pc[9];
  assign \from_pc[9] = from_pc[9];
  assign to_iram[6] = \from_pc[8];
  assign \from_pc[8] = from_pc[8];
  assign to_iram[5] = \from_pc[7];
  assign \from_pc[7] = from_pc[7];
  assign to_iram[4] = \from_pc[6];
  assign \from_pc[6] = from_pc[6];
  assign to_iram[3] = \from_pc[5];
  assign \from_pc[5] = from_pc[5];
  assign to_iram[2] = \from_pc[4];
  assign \from_pc[4] = from_pc[4];
  assign to_iram[1] = \from_pc[3];
  assign \from_pc[3] = from_pc[3];
  assign to_iram[0] = \from_pc[2];
  assign \from_pc[2] = from_pc[2];
endmodule

