
module eth_crc(Clk,Reset,Data,Enable,Initialize,Crc,CrcError);

  parameter  Tp = 1;
  input  Clk;
  input  Reset;
  input  [3:0] Data;
  input  Enable;
  input  Initialize;
  output [31:0] Crc;
  output CrcError;
  reg  [31:0] Crc;
  wire [31:0] CrcNext;

  assign CrcNext[0] = (((Enable & ~Data[0]) & Crc[28]) | (Data[0] & Enable)) & (~Data[0] | ~Crc[28]);
  assign CrcNext[1] = (Enable & ((~(((((Crc[28] | ~(Data[1] & ~Crc[28])) & (Crc[28] | (~Crc[28] & Data[0]))) | (Data[1] & ~(~Crc[28] & Data[0]))) & (((Crc[28] | ~(Data[1] & ~Crc[28])) & (Crc[28] | (~Crc[28] & Data[0]))) | ~Crc[28])) & ((~((~Data[0] & Data[1]) | (Data[0] & (~Data[1] | (~Data[0] & Data[1])))) | (~Crc[28] & (Data[0] & (~Data[1] | (~Data[0] & Data[1]))))) | ((~Data[0] & Data[1]) & (~Crc[28] & (~Data[1] | (~Data[0] & Data[1])))))) | (~Crc[28] | Crc[28])) & Crc[29])) ^ (Enable & ((~(((((Crc[28] | ~(Data[1] & ~Crc[28])) & (Crc[28] | (~Crc[28] & Data[0]))) | (Data[1] & ~(~Crc[28] & Data[0]))) & (((Crc[28] | ~(Data[1] & ~Crc[28])) & (Crc[28] | (~Crc[28] & Data[0]))) | ~Crc[28])) & ((~((~Data[0] & Data[1]) | (Data[0] & (~Data[1] | (~Data[0] & Data[1])))) | (~Crc[28] & (Data[0] & (~Data[1] | (~Data[0] & Data[1]))))) | ((~Data[0] & Data[1]) & (~Crc[28] & (~Data[1] | (~Data[0] & Data[1])))))) | (~Crc[28] | Crc[28])) & (((((Crc[28] | ~(Data[1] & ~Crc[28])) & (Crc[28] | (~Crc[28] & Data[0]))) | (Data[1] & ~(~Crc[28] & Data[0]))) & (((Crc[28] | ~(Data[1] & ~Crc[28])) & (Crc[28] | (~Crc[28] & Data[0]))) | ~Crc[28])) & ((~((~Data[0] & Data[1]) | (Data[0] & (~Data[1] | (~Data[0] & Data[1])))) | (~Crc[28] & (Data[0] & (~Data[1] | (~Data[0] & Data[1]))))) | ((~Data[0] & Data[1]) & (~Crc[28] & (~Data[1] | (~Data[0] & Data[1]))))))));
  
  always @(posedge Clk or posedge Reset)
      begin
        if (Reset) Crc <= 32'hffffffff;
        else if (Initialize) Crc <= 32'hffffffff;
        else Crc <= CrcNext;
      end
  assign CrcError = Crc[31:0] != 32'hc704dd7b;
endmodule

