module's undeclared outputs) 
always @(MIERHW) begin 
   for (i=0; i<=5; i=i+1) begin 
      MTEMP1[3:0] = {MIERHW[i*3+3], 
                     MIERHW[i*3+2],
                     MIERHW[i*3+1],
                     MIERHW[i*3+0]};
      casex (MTEMP1) 
      endcase
   end
   {MBOOTH_P[i*4+3], 
    MBOOTH_P[i*4+2],
    MBOOTH_P[i*4+1],
    MBOOTH_P[i*4+0]}     = MTEMP2[3:0];
end
`define DMCLASH MCLASH 
`define DCONST 1'b1 
always @(CEIopMADH_E_D2_R or CEIopMAZH_E_D2_R or DDATAH or DIV2HI or MCLA or MCLASH
         or MULTSHCYC or MULTUSCYC)  begin 
   case (1'b1) 
   endcase
end
endmodule 