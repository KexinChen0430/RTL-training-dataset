module watchdog(
    input nLDS, RW,             
    input A23I, A22I,           
    input [21:17] M68K_ADDR_U,  
    input WDCLK,                
    output nHALT,               
    output nRESET,              
    input nRST                  
);
    reg [3:0] WDCNT;
    initial
        WDCNT <= 4'b0000;
    assign nRESET = nRST & ~WDCNT[3];
    assign nHALT = nRESET;
    assign WDRESET = &{nRST, ~|{nLDS, RW, A23I, A22I}, M68K_ADDR_U[21:20], ~|{M68K_ADDR_U[19:17]}};
    always @(posedge WDCLK or posedge WDRESET or posedge ~nRST)
    begin
        if (WDRESET)
        begin
            WDCNT <= 4'b0000;
        end
        else if (!nRST)
        begin
            WDCNT <= 4'b1110;            
        end
        else
        begin
            WDCNT <= WDCNT + 1'b1;
        end
    end
endmodule