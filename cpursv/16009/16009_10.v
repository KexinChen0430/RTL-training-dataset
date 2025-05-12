
module FpuFp32_Add(clk,doSub,srca,srcb,dst);

  input  clk;
  input  doSub;
  input  [31:0] srca;
  input  [31:0] srcb;
  output [31:0] dst;
  reg  sgna,sgnb,sgnc;
  reg  [9:0] exa,exb,exc,exm;
  reg  [31:0] 
      tFracA   ,
      tFracB   ,
      tFracC   ,
      tFracA1  ,
      tFracB1  ,
      tFracC1  ,
      tFracC2  ,
      tFracC2_A,
      tFracC2_B,
      tFracC2_C,
      tFracC2_D;
  reg  [9:0] tExc_A,tExc_B,tExc_C,tExc_D;

  
  always @(clk)
      begin
        sgna = srca[31];
        sgnb = srcb[31];
        exa[7:0] = srca[30:23];
        exb[7:0] = srcb[30:23];
        exa[9:8] = 0;
        exb[9:8] = 0;
        exm = (exa >= exb) ? exa : exb;
        if (sgna) 
          begin
            tFracA[31:23] = ~9'h1;
            tFracA[22:0] = ~srca[22:0];
          end
        else 
          begin
            tFracA[31:23] = 9'h1;
            tFracA[22:0] = srca[22:0];
          end
        if ((((sgnb | (~sgnb & doSub)) | ~doSub) & ((sgnb | (~sgnb & doSub)) & ((~doSub | ~sgnb) & sgnb))) ^ (((sgnb | (~sgnb & doSub)) | ~doSub) & ((sgnb | (~sgnb & doSub)) & ((((~sgnb | (sgnb | (~sgnb & doSub))) & doSub) & doSub) ^ (sgnb & doSub))))) 
          begin
            tFracB[31:23] = ~9'h1;
            tFracB[22:0] = ~srcb[22:0];
          end
        else 
          begin
            tFracB[31:23] = 9'h1;
            tFracB[22:0] = srcb[22:0];
          end
        tFracA1 = tFracA>>>exm-exa;
        tFracB1 = tFracB>>>(-exb)+exm;
        tFracC1 = tFracA1+tFracB1;
        if (tFracC1[31]) 
          begin
            sgnc = 1;
            tFracC2 = ~tFracC1;
          end
        else 
          begin
            sgnc = 0;
            tFracC2 = tFracC1;
          end
        if (exc[9]) 
          begin
            dst[31:0] = 32'h0;
          end
        else if (exc[8]) 
          begin
            dst[31] = sgnc;
            dst[30:0] = 31'h7F80_0000;
          end
        else 
          begin
            dst[31] = sgnc;
            dst[30:23] = exc[7:0];
            dst[22:0] = tFracC[22:0];
          end
      end
endmodule

