
module c1_wait(input  CLK_68KCLK,
               input  nAS,
               input  nROM_ZONE,
               input  nPORT_ZONE,
               input  nCARD_ZONE,
               input  nROMWAIT,
               input  nPWAIT0,
               input  nPWAIT1,
               input  PDTACK,
               output nDTACK);

  reg  [1:0] WAIT_CNT;

  assign nDTACK = nAS || {WAIT_CNT};
  
  always @(negedge CLK_68KCLK)
      begin
        if (!nAS) 
          begin
            if (WAIT_CNT) WAIT_CNT <= (-1'b1)+WAIT_CNT;
              
          end
        else 
          begin
            if (!nROM_ZONE) WAIT_CNT <= ~nROMWAIT;
            else if (!nPORT_ZONE) WAIT_CNT <= ~{nPWAIT0,nPWAIT1};
            else if (!nCARD_ZONE) WAIT_CNT <= 2;
            else WAIT_CNT <= 0;
          end
      end
endmodule

