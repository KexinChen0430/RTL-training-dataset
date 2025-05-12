module TSHX2DQSA(
    input T0,     
    input T1,     
    input SCLK,   
    input ECLK,   
    input DQSW,   
    input RST,    
    output Q      
);
    parameter GSR = "ENABLED";   
    parameter REGSET = "SET";    
endmodule 