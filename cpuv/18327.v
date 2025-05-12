module SyncPulse( 
                  sCLK, 
                  sRST, 
                  dCLK, 
                  sEN, 
                  dPulse 
                  );
   input     sCLK ; 
   input     sRST ; 
   input     sEN ; 
   input     dCLK ; 
   output    dPulse ; 
   reg       sSyncReg; 
   reg       dSyncReg1, dSyncReg2; 
   reg       dSyncPulse; 
   assign    dPulse = dSyncReg2 != dSyncPulse ;
   always @(posedge sCLK or `BSV_RESET_EDGE sRST)
     begin
        if (sRST == `BSV_RESET_VALUE)
          sSyncReg <= `BSV_ASSIGNMENT_DELAY 1'b0 ;
        else
          begin
             if ( sEN )
               begin
                  sSyncReg <= `BSV_ASSIGNMENT_DELAY ! sSyncReg ;
               end
          end 
     end 
   always @(posedge dCLK or `BSV_RESET_EDGE sRST )
      begin
         if (sRST == `BSV_RESET_VALUE)
            begin
               dSyncReg1 <= `BSV_ASSIGNMENT_DELAY 1'b0 ;
               dSyncReg2 <= `BSV_ASSIGNMENT_DELAY 1'b0 ;
               dSyncPulse <= `BSV_ASSIGNMENT_DELAY 1'b0 ;
            end 
         else
           begin
              dSyncReg1 <= `BSV_ASSIGNMENT_DELAY sSyncReg ;
              dSyncReg2 <= `BSV_ASSIGNMENT_DELAY dSyncReg1 ;
              dSyncPulse <= `BSV_ASSIGNMENT_DELAY dSyncReg2 ;
           end 
      end 
`ifdef BSV_NO_INITIAL_BLOCKS
`else 
   initial
      begin
         sSyncReg   = 1'b0 ;
         dSyncReg1  = 1'b0 ;
         dSyncReg2  = 1'b0 ;
         dSyncPulse = 1'b0 ;
      end 
`endif 
endmodule