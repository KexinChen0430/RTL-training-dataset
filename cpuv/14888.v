module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(
    FCLK_RESET0_N, MIO, DDR_CAS_n, DDR_CKE,
    DDR_Clk_n, DDR_Clk, DDR_CS_n, DDR_DRSTB, DDR_ODT, DDR_RAS_n, DDR_WEB, DDR_BankAddr, DDR_Addr,
    DDR_VRN, DDR_VRP, DDR_DM, DDR_DQ, DDR_DQS_n, DDR_DQS, PS_SRSTB, PS_CLK, PS_PORB)
;
output FCLK_RESET0_N;
inout [53:0]MIO;
inout DDR_CAS_n;       
inout DDR_CKE;         
inout DDR_Clk_n;       
inout DDR_Clk;         
inout DDR_CS_n;        
inout DDR_DRSTB;       
inout DDR_ODT;         
inout DDR_RAS_n;       
inout DDR_WEB;         
inout [2:0]DDR_BankAddr; 
inout [14:0]DDR_Addr;    
inout DDR_VRN;         
inout DDR_VRP;         
inout [3:0]DDR_DM;     
inout [31:0]DDR_DQ;    
inout [3:0]DDR_DQS_n;  
inout [3:0]DDR_DQS;    
inout PS_SRSTB;        
inout PS_CLK;          
inout PS_PORB;         
endmodule