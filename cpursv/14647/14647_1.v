
module REGBANK_banco  #(parameter  addr_bits = 5, word_wide = 32)
  (input  clock,
   input  regWrite,
   input  [(-1)+addr_bits:0] readReg1,
   input  [(-1)+addr_bits:0] readReg2,
   input  [(-1)+addr_bits:0] writeReg,
   input  reset,
   input  [(-1)+word_wide:0] writeData,
   output [(-1)+word_wide:0] readData1,
   output [(-1)+word_wide:0] readData2);

  localparam  bank_depth = 1<<addr_bits;
  reg  [(-1)+word_wide:0] banco[(-1)+bank_depth:0];

  assign readData1 = banco[readReg1];
  assign readData2 = banco[readReg2];
  
  always @(posedge clock or posedge reset)
      begin
        if (reset) 
          begin
            banco[0] = 0;
            banco[1] = 0;
            banco[1<<<1] = 0;
            banco[3] = 0;
            banco[4] = 0;
            banco[5] = 0;
            banco[6] = 0;
            banco[7] = 0;
            banco[8] = 0;
            banco[9] = 0;
            banco[10] = 0;
            banco[11] = 0;
            banco[12] = 0;
            banco[13] = 0;
            banco[14] = 0;
            banco[15] = 0;
            banco[16] = 0;
            banco[17] = 0;
            banco[18] = 0;
            banco[19] = 0;
            banco[20] = 0;
            banco[21] = 0;
            banco[22] = 0;
            banco[23] = 0;
            banco[24] = 0;
            banco[25] = 0;
            banco[26] = 0;
            banco[27] = 0;
            banco[28] = 0;
            banco[29] = 0;
            banco[30] = 0;
            banco[31] = 0;
          end
        else if (regWrite) 
          begin
            banco[writeReg] = writeData;
          end
          
      end
endmodule

