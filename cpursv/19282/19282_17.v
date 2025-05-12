
module fb_crc(Clk,Reset,Data,Enable,Initialize,Crc,CrcError);

  input  Clk;
  input  Reset;
  input  [3:0] Data;
  input  Enable;
  input  Initialize;
  output [7:0] Crc;
  output CrcError;
  reg  [7:0] Crc;
  wire [7:0] Crc1;
  wire [7:0] Crc2;
  wire [7:0] Crc3;
  wire [7:0] Crc4;

  assign Crc1[7] = ((((Enable & ~Crc[6]) & Crc[7]) ^ (~Crc[6] & (Enable & Data[3]))) | ~(((~Crc[7] & (Enable & Data[3])) | (Enable & ~Data[3])) & ((Crc[7] | ~Crc[7]) & (Crc[7] | Data[3])))) & ((((Enable & ~Crc[6]) & Crc[7]) ^ (~Crc[6] & (Enable & Data[3]))) | Crc[6]);
  assign Crc1[6] = Crc[5];
  assign Crc1[5] = ((Crc[4] & ~(((~Crc[7] & (Enable & Data[3])) | (Enable & ~Data[3])) & ((Crc[7] | ~Crc[7]) & (Crc[7] | Data[3])))) | (((Crc[7] & Enable) & ~Crc[4]) & ~((Enable & Data[3]) & ~Crc[4]))) | (~((Crc[7] & Enable) & ~Crc[4]) & ((Enable & Data[3]) & ~Crc[4]));
  assign Crc1[4] = Crc[3];
  assign Crc1[3] = Crc[2];
  assign Crc1[2] = ((Crc[1] & ~(((~Crc[7] & (Enable & Data[3])) | (Enable & ~Data[3])) & ((Crc[7] | ~Crc[7]) & (Crc[7] | Data[3])))) | ((Enable & (~Crc[1] & Crc[7])) & ~(Enable & (~Crc[1] & Data[3])))) | (~(Enable & (~Crc[1] & Crc[7])) & (Enable & (~Crc[1] & Data[3])));
  assign Crc1[1] = ((Enable | (((~Crc[0] | ~(((~Crc[7] & (Enable & Data[3])) | (Enable & ~Data[3])) & ((Crc[7] | ~Crc[7]) & (Crc[7] | Data[3])))) & ~(((~Crc[7] & (Enable & Data[3])) | (Enable & ~Data[3])) & ((Crc[7] | ~Crc[7]) & (Crc[7] | Data[3])))) & Crc[0])) & (((~Data[3] | ~Crc[7]) & ((Crc[7] | ~Crc[7]) & (Crc[7] | Data[3]))) | (((~Crc[0] | ~(((~Crc[7] & (Enable & Data[3])) | (Enable & ~Data[3])) & ((Crc[7] | ~Crc[7]) & (Crc[7] | Data[3])))) & ~(((~Crc[7] & (Enable & Data[3])) | (Enable & ~Data[3])) & ((Crc[7] | ~Crc[7]) & (Crc[7] | Data[3])))) & Crc[0]))) & (~Crc[0] | ~(((~Crc[7] & (Enable & Data[3])) | (Enable & ~Data[3])) & ((Crc[7] | ~Crc[7]) & (Crc[7] | Data[3]))));
  assign Crc1[0] = ((~Crc[7] & (Enable & Data[3])) | (Enable & ~Data[3])) & ((Crc[7] | ~Crc[7]) & (Crc[7] | Data[3]));
  assign Crc2[7] = ((((~Crc1[6] | ~((((Data[2] & (Enable & ~Crc1[7])) | ~Data[2]) & ((Data[2] & (Enable & ~Crc1[7])) | Crc1[7])) & Enable)) & Crc1[6]) & ~((((Data[2] & (Enable & ~Crc1[7])) | ~Data[2]) & ((Data[2] & (Enable & ~Crc1[7])) | Crc1[7])) & Enable)) | (((~Crc1[6] & Enable) & Crc1[7]) & ~(~Crc1[6] & (Data[2] & Enable)))) | (~((~Crc1[6] & Enable) & Crc1[7]) & (~Crc1[6] & (Data[2] & Enable)));
  assign Crc2[6] = Crc1[5];
  assign Crc2[5] = ((((Data[2] & (Enable & ~Crc1[7])) | ~Data[2]) & ((Data[2] & (Enable & ~Crc1[7])) | Crc1[7])) & Enable) ^ Crc1[4];
  assign Crc2[4] = Crc1[3];
  assign Crc2[3] = Crc1[2];
  assign Crc2[2] = (Crc1[1] & ~((((Data[2] & (Enable & ~Crc1[7])) | ~Data[2]) & ((Data[2] & (Enable & ~Crc1[7])) | Crc1[7])) & Enable)) | ((((Crc1[1] & ~((((Data[2] & (Enable & ~Crc1[7])) | ~Data[2]) & ((Data[2] & (Enable & ~Crc1[7])) | Crc1[7])) & Enable)) | ~Crc1[1]) & ((~Data[2] | ~Crc1[7]) & ((Crc1[7] | Data[2]) & (Crc1[7] | ~Crc1[7])))) & Enable);
  assign Crc2[1] = ((Crc1[0] & ~((((Data[2] & (Enable & ~Crc1[7])) | ~Data[2]) & ((Data[2] & (Enable & ~Crc1[7])) | Crc1[7])) & Enable)) | (Enable & (~Crc1[0] & (Data[2] & ~Crc1[7])))) | (Enable & ((~Crc1[0] & Crc1[7]) & ~Data[2]));
  assign Crc2[0] = (((Data[2] & (Enable & ~Crc1[7])) | ~Data[2]) & ((Data[2] & (Enable & ~Crc1[7])) | Crc1[7])) & Enable;
  assign Crc3[7] = ((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | (~(Data[1] & Enable) & Crc2[7])) & ((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | ((Data[1] & Enable) & ~Crc2[7])) | Enable)) ^ Crc2[6];
  assign Crc3[6] = Crc2[5];
  assign Crc3[5] = (((~Crc2[4] | ~((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | (~(Data[1] & Enable) & Crc2[7])) & ((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | ((Data[1] & Enable) & ~Crc2[7])) | Enable))) & (Data[1] & Enable)) ^ ((~Crc2[4] | ~((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | (~(Data[1] & Enable) & Crc2[7])) & ((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | ((Data[1] & Enable) & ~Crc2[7])) | Enable))) & (Crc2[7] & Enable))) | (~((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | (~(Data[1] & Enable) & Crc2[7])) & ((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | ((Data[1] & Enable) & ~Crc2[7])) | Enable)) & Crc2[4]);
  assign Crc3[4] = Crc2[3];
  assign Crc3[3] = Crc2[2];
  assign Crc3[2] = ((~((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | (~(Data[1] & Enable) & Crc2[7])) & ((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | ((Data[1] & Enable) & ~Crc2[7])) | Enable)) & Crc2[1]) | ((~Crc2[1] & Enable) & (~Crc2[7] & Data[1]))) | ((~Data[1] & (Crc2[7] & Enable)) & ~Crc2[1]);
  assign Crc3[1] = ((Crc2[0] | (((Data[1] & Enable) & ~Crc2[0]) & ~((~Crc2[0] & Crc2[7]) & Enable))) | (~((Data[1] & Enable) & ~Crc2[0]) & ((~Crc2[0] & Crc2[7]) & Enable))) & (~((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | (~(Data[1] & Enable) & Crc2[7])) & ((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | ((Data[1] & Enable) & ~Crc2[7])) | Enable)) | ~Crc2[0]);
  assign Crc3[0] = (((Data[1] & Enable) & ~(Crc2[7] & Enable)) | (~(Data[1] & Enable) & Crc2[7])) & ((((Data[1] & Enable) & ~(Crc2[7] & Enable)) | ((Data[1] & Enable) & ~Crc2[7])) | Enable);
  assign Crc4[7] = ((((~Crc3[6] | ~((~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable))))) & Crc3[6]) & ~((~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable))))) | ((~Crc3[6] & (Enable & Crc3[7])) & ~(Data[0] & Enable))) | (~Crc3[6] & (~(Enable & Crc3[7]) & (Data[0] & Enable)));
  assign Crc4[6] = Crc3[5];
  assign Crc4[5] = (((((Data[0] & (Enable & ~Crc3[7])) | (~((~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable)))) & Crc3[4])) | (Enable & Crc3[7])) & (((Data[0] & (Enable & ~Crc3[7])) | (~((~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable)))) & Crc3[4])) | ~Data[0])) & (~((~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable)))) & Crc3[4])) | (((((Data[0] & (Enable & ~Crc3[7])) | (~((~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable)))) & Crc3[4])) | (Enable & Crc3[7])) & (((Data[0] & (Enable & ~Crc3[7])) | (~((~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable)))) & Crc3[4])) | ~Data[0])) & ~Crc3[4]);
  assign Crc4[4] = Crc3[3];
  assign Crc4[3] = Crc3[2];
  assign Crc4[2] = ((Crc3[1] | (~Crc3[1] & (~(Enable & Crc3[7]) & (Data[0] & Enable)))) | ((~Crc3[1] & (Enable & ~(Data[0] & Enable))) & Crc3[7])) & (~((~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable)))) | ~Crc3[1]);
  assign Crc4[1] = ((Crc3[0] & ~((~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable))))) | ((~Crc3[0] | ~((~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable))))) & (~(Enable & Crc3[7]) & (Data[0] & Enable)))) | ((~Crc3[0] | ~((~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable))))) & (Crc3[7] & (Enable & ~(Data[0] & Enable))));
  assign Crc4[0] = (~(Data[0] & Enable) | (~(Enable & Crc3[7]) & (Data[0] & Enable))) & ((Enable & Crc3[7]) | (~(Enable & Crc3[7]) & (Data[0] & Enable)));
  
  always @(posedge Clk or posedge Reset)
      begin
        if (Reset) Crc <= 8'hff;
        else if (Initialize) Crc <= 8'hff;
        else Crc <= Crc4;
      end
  assign CrcError = Crc[7:0] != 32'h7b;
endmodule

