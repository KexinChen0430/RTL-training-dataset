module aurora_64b66b_25p4G_SCRAMBLER_64B66B #
(
    parameter SCRAMBLER_SEED = 58'h2AA_AAAA_AAAA_AAAA, 
    parameter TX_DATA_WIDTH = 64 
)
(
    UNSCRAMBLED_DATA_IN, 
    SCRAMBLED_DATA_OUT, 
    DATA_VALID_IN, 
    USER_CLK, 
    SYSTEM_RESET 
);
    input   [0:(TX_DATA_WIDTH-1)] UNSCRAMBLED_DATA_IN; 
    input                         DATA_VALID_IN; 
    output  [(TX_DATA_WIDTH-1):0] SCRAMBLED_DATA_OUT; 
    input   USER_CLK; 
    input   SYSTEM_RESET; 
    integer                        i; 
    reg     [57:0]                 poly; 
    reg     [57:0]                 scrambler = SCRAMBLER_SEED; 
    reg     [0:(TX_DATA_WIDTH-1)]  tempData = {TX_DATA_WIDTH{1'b0}}; 
    reg                            xorBit; 
    reg     [(TX_DATA_WIDTH-1):0]  SCRAMBLED_DATA_OUT; 
    always @(scrambler,UNSCRAMBLED_DATA_IN)
    begin
        poly = scrambler; 
        for (i=0;i<=(TX_DATA_WIDTH-1);i=i+1)
        begin
            xorBit = UNSCRAMBLED_DATA_IN[i] ^ poly[38] ^ poly[57]; 
            poly = {poly[56:0],xorBit}; 
            tempData[i] = xorBit; 
        end
    end
    always @(posedge USER_CLK)
    begin
        if (DATA_VALID_IN) 
        begin
            SCRAMBLED_DATA_OUT <= `DLY  tempData; 
            scrambler          <= `DLY  poly; 
        end
    end
endmodule