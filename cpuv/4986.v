module x (
          MIERHW, MBOOTH_P, CEIopMADH_E_D2_R, CEIopMAZH_E_D2_R, DDATAH, DIV2HI, HI_R, MCLA, MCLASH,
          MULTSHCYC, MULTUSCYC, HI_P
          );
   input [18:0] MIERHW;
   integer      i;
   integer      MTEMP1;
   integer      MTEMP2;
   input        MBOOTH_P;
   input        CEIopMADH_E_D2_R;
   input        CEIopMAZH_E_D2_R;
   input        DDATAH;
   input        DIV2HI;
   input        HI_R;
   input        MCLA;
   input        MCLASH;
   input        MULTSHCYC;
   input        MULTUSCYC;
   input        HI_P;
   always @(MIERHW) begin
      for (i=0; i<=5; i=i+1) begin
         MTEMP1[3:0]  = {MIERHW[i*3+3],
                         MIERHW[i*3+2],
                         MIERHW[i*3+1],
                         MIERHW[i*3+0]};
         casex (MTEMP1)
           4'b0000: MTEMP2  = 4'b0101; 
           4'b0001: MTEMP2  = 4'b0001; 
           4'b0010: MTEMP2  = 4'b0001; 
           4'b0011: MTEMP2  = 4'b0010; 
           4'b0100: MTEMP2  = 4'b0010; 
           4'b0101: MTEMP2  = 4'b0100; 
           4'b0110: MTEMP2  = 4'b0100; 
           4'b0111: MTEMP2  = 4'b1000; 
           4'b1000: MTEMP2  = 4'b0111; 
           4'b1001: MTEMP2  = 4'b1011; 
           4'b1010: MTEMP2  = 4'b1011; 
           4'b1011: MTEMP2  = 4'b1101; 
           4'b1100: MTEMP2  = 4'b1101; 
           4'b1101: MTEMP2  = 4'b1110; 
           4'b1110: MTEMP2  = 4'b1110; 
           4'b1111: MTEMP2  = 4'b1010; 
         endcase
      end
      {MBOOTH_P[i*4+3],
       MBOOTH_P[i*4+2],
       MBOOTH_P[i*4+1],
       MBOOTH_P[i*4+0]}  = MTEMP2[3:0];
   end
`define DMCLASH MCLASH
`define DCONST 1'b1
   always @(CEIopMADH_E_D2_R or CEIopMAZH_E_D2_R or DDATAH or DIV2HI or MCLA or MCLASH
            or MULTSHCYC or MULTUSCYC)  begin
      case (1'b1)
        CEIopMADH_E_D2_R: HI_P  = MCLA;
        CEIopMAZH_E_D2_R: HI_P  = MCLA;
        DIV2HI:           HI_P  = DDATAH;
        MULTUSCYC:        HI_P  = MCLA;
        MULTSHCYC:        HI_P  = `DMCLASH;
        default:          HI_P  = `DCONST;
      endcase
   end
endmodule