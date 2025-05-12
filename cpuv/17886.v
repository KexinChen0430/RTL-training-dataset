module SyncHandshake(
    sCLK,      
    sRST,      
    dCLK,      
    sEN,       
    sRDY,      
    dPulse     
);
parameter init = 1'b0;
input     sCLK;       
input     sRST;       
input     sEN;        
output    sRDY;       
input     dCLK;       
output    dPulse;     
reg       dSyncReg1, dSyncReg2; 
reg       dLastState;           
reg       sToggleReg;           
reg       sSyncReg1, sSyncReg2; 
assign    dPulse = dSyncReg2 != dLastState;
assign    sRDY = sSyncReg2 == sToggleReg;
always @(posedge sCLK or `BSV_RESET_EDGE sRST)
    begin
        if (sRST == `BSV_RESET_VALUE) 
            begin
                sSyncReg1  <= `BSV_ASSIGNMENT_DELAY !init;
                sSyncReg2  <= `BSV_ASSIGNMENT_DELAY !init;
                sToggleReg <= `BSV_ASSIGNMENT_DELAY init;
            end
        else 
            begin
                sSyncReg1 <= `BSV_ASSIGNMENT_DELAY dSyncReg2;
                sSyncReg2 <= `BSV_ASSIGNMENT_DELAY sSyncReg1;
                if (sEN)
                    begin
                        sToggleReg <= `BSV_ASSIGNMENT_DELAY !sToggleReg;
                    end
            end
    end
always @(posedge dCLK or `BSV_RESET_EDGE sRST)
    begin
        if (sRST == `BSV_RESET_VALUE) 
            begin
                dSyncReg1  <= `BSV_ASSIGNMENT_DELAY init;
                dSyncReg2  <= `BSV_ASSIGNMENT_DELAY init;
                dLastState <= `BSV_ASSIGNMENT_DELAY init;
            end
        else 
            begin
                dSyncReg1 <= `BSV_ASSIGNMENT_DELAY sToggleReg;
                dSyncReg2 <= `BSV_ASSIGNMENT_DELAY dSyncReg1;
                dLastState <= `BSV_ASSIGNMENT_DELAY dSyncReg2;
            end
    end
`ifdef BSV_NO_INITIAL_BLOCKS
`else 
    initial
        begin
            dSyncReg1 = init;
            dSyncReg2 = init;
            dLastState = init;
            sToggleReg = init;
            sSyncReg1 = !init;
            sSyncReg2 = !init;
        end 
`endif 
endmodule 