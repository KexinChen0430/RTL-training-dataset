module JTAGG(
    input TCK,   
    input TMS,   
    input TDI,   
    input JTDO2, 
    input JTDO1, 
    output TDO,  
    output JTDI, 
    output JTCK, 
    output JRTI2, 
    output JRTI1, 
    output JSHIFT,  
    output JUPDATE, 
    output JRSTN,   
    output JCE2,    
    output JCE1     
);
parameter ER1 = "ENABLED"; 
parameter ER2 = "ENABLED"; 
endmodule