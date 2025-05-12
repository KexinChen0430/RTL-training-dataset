module SyncHandshake(
    sCLK,       
    sRST_N,     
    dCLK,       
    sEN,        
    sRDY,       
    dPulse      
);
parameter init = 1'b0;
input     sCLK;       
input     sRST_N;     
input     sEN;        
output    sRDY;       
input     dCLK;       
output    dPulse;     
reg       dToggleReg;     
reg       dSyncReg1, dSyncReg2; 
reg       dLastState;     
reg       sToggleReg;     
reg       sSyncReg1, sSyncReg2; 
reg       sLastState;     
reg       sRDY_reg;       
wire      pulseSignal;
assign    dPulse = pulseSignal;
assign    pulseSignal = dSyncReg2 != dLastState;
assign    sRDY = sRDY_reg;
always @(posedge sCLK or negedge sRST_N)
  begin
     if (sRST_N == 0) 
        begin
           sRDY_reg   <= `BSV_ASSIGNMENT_DELAY 1'b1;
           sSyncReg1  <= `BSV_ASSIGNMENT_DELAY init;
           sSyncReg2  <= `BSV_ASSIGNMENT_DELAY init;
           sLastState <= `BSV_ASSIGNMENT_DELAY init;
           sToggleReg <= `BSV_ASSIGNMENT_DELAY init;
        end
     else 
        begin
           sSyncReg1 <= `BSV_ASSIGNMENT_DELAY dToggleReg; 
           sSyncReg2 <= `BSV_ASSIGNMENT_DELAY sSyncReg1;
           sLastState <= `BSV_ASSIGNMENT_DELAY sSyncReg2;
           if (sEN)
             begin
                sToggleReg <= `BSV_ASSIGNMENT_DELAY !sToggleReg;
             end
           if (sEN)
             begin
                sRDY_reg <= `BSV_ASSIGNMENT_DELAY 1'b0;
             end
           else if (sSyncReg2 != sLastState)
             begin
                sRDY_reg <= `BSV_ASSIGNMENT_DELAY 1'b1;
             end
        end
  end
always @(posedge dCLK or negedge sRST_N)
  begin
     if (sRST_N == 0) 
       begin
          dSyncReg1  <= `BSV_ASSIGNMENT_DELAY init;
          dSyncReg2  <= `BSV_ASSIGNMENT_DELAY init;
          dLastState <= `BSV_ASSIGNMENT_DELAY init;
          dToggleReg <= `BSV_ASSIGNMENT_DELAY init;
       end
     else 
        begin
           dSyncReg1 <= `BSV_ASSIGNMENT_DELAY sToggleReg; 
           dSyncReg2 <= `BSV_ASSIGNMENT_DELAY dSyncReg1;
           dLastState <= `BSV_ASSIGNMENT_DELAY dSyncReg2;
           if (pulseSignal)
             begin
                dToggleReg <= `BSV_ASSIGNMENT_DELAY !dToggleReg;
             end
        end
  end
`ifdef BSV_NO_INITIAL_BLOCKS
`else 
   initial
      begin
         dSyncReg1 = init;
         dSyncReg2 = init;
         dLastState = init;
         dToggleReg = init;
         sToggleReg = init;
         sSyncReg1 = init;
         sSyncReg2 = init;
         sLastState = init;
         sRDY_reg = 1'b1;
      end 
`endif 
endmodule 