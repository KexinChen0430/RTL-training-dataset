module aurora_64b66b_25p4G_DESCRAMBLER_64B66B #
(
    parameter SCRAMBLER_SEED = 58'h2AA_AAAA_AAAA_AAAA,
    parameter RX_DATA_WIDTH = 64
)
(
    SCRAMBLED_DATA_IN,          
    UNSCRAMBLED_DATA_OUT,       
    DATA_VALID_IN,              
    USER_CLK,                   
    SYSTEM_RESET                
);
input   [0:(RX_DATA_WIDTH-1)] SCRAMBLED_DATA_IN; 
input                         DATA_VALID_IN;     
output  [(RX_DATA_WIDTH-1):0] UNSCRAMBLED_DATA_OUT; 
input              USER_CLK;        
input              SYSTEM_RESET;    
reg     [57:0]                 descrambler; 
integer                        i;           
reg     [57:0]                 poly;        
reg     [0:(RX_DATA_WIDTH-1)]  tempData;    
reg     [(RX_DATA_WIDTH-1):0]  unscrambled_data_i; 
reg                            xorBit;      
always @(descrambler,SCRAMBLED_DATA_IN)
begin
    poly = descrambler; 
    for (i=0;i<=(RX_DATA_WIDTH-1);i=i+1)
    begin
        xorBit = SCRAMBLED_DATA_IN[i] ^ poly[38] ^ poly[57];
        poly = {poly[56:0],SCRAMBLED_DATA_IN[i]};
        tempData[i] = xorBit;
    end
end
always @(posedge USER_CLK)
begin
    if (SYSTEM_RESET)
    begin
        unscrambled_data_i <= `DLY  'h0;
        descrambler        <= `DLY  SCRAMBLER_SEED;
    end
    else if (DATA_VALID_IN)
    begin
        unscrambled_data_i <= `DLY  tempData;
        descrambler        <= `DLY  poly;
    end
end
assign UNSCRAMBLED_DATA_OUT = unscrambled_data_i; 
endmodule 