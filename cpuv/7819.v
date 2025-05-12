module aur1_FRAME_GEN
(
    TX_D,               
    TX_SRC_RDY_N,       
    TX_DST_RDY_N,       
    USER_CLK,           
    RESET,              
    CHANNEL_UP          
);
    output  [0:63]     TX_D;          
    output             TX_SRC_RDY_N;  
    input              TX_DST_RDY_N;  
    input              USER_CLK;      
    input              RESET;         
    input              CHANNEL_UP;    
    reg                TX_SRC_RDY_N;  
    reg     [0:15]     data_lfsr_r;   
    wire               reset_c;       
    assign reset_c = RESET || !CHANNEL_UP; 
    always @(posedge USER_CLK)        
        if(reset_c)                   
        begin
            data_lfsr_r          <=  `DLY    16'hABCD;  
            TX_SRC_RDY_N    <=  `DLY    1'b1;           
        end
        else if(!TX_DST_RDY_N)        
        begin
            data_lfsr_r          <=  `DLY    {!{data_lfsr_r[3]^data_lfsr_r[12]^data_lfsr_r[14]^data_lfsr_r[15]},
                                data_lfsr_r[0:14]}; 
            TX_SRC_RDY_N    <=  `DLY    1'b0;           
        end
    assign  TX_D    =   {4{data_lfsr_r}}; 
endmodule