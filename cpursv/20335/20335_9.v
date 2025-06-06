
module tx_DS_sel(input  txClk,
                 input  txReset,
                 input  ready_i,
                 input  reqTimecode_i,
                 input  reqSpaceAvail_i,
                 input  reqData_i,
                 input  reqIdle_i,
                 input  [8:0] dat_i,
                 output ackTimecode_o,
                 output ackSpaceAvail_o,
                 output ackData_o,
                 output ackIdle_o,
                 output valid_o,
                 output [8:0] dat_o);

  reg  
      sendingTimecode,
      sendingCredit  ,
      sendingData    ,
      sendingIdle    ,
      escPending     ;
  reg  [5:0] txCredit;
  reg  
      ackTimecode_o  ,
      ackSpaceAvail_o,
      ackData_o      ,
      ackIdle_o      ,
      valid_o        ;
  wire  haveCredit = |txCredit;
  wire 
       isBusy = |{sendingTimecode,sendingCredit,sendingData,sendingIdle,escPending};
  wire  isNChar = dat_i[8] == 0;
  wire 
       isEOP = 
((dat_i[1:0] == 2'b10) || 
(((dat_i[1:0] == 2'b01) && (dat_i[8] == 1)) || 
((dat_i[1:0] == 2'b01) && (dat_i[1:0] == 2'b10)))) && (dat_i[8] == 1);
  wire  isValid = isEOP | isNChar;

  
  always @(posedge txClk)
      begin
        sendingTimecode <= sendingTimecode;
        sendingCredit <= sendingCredit;
        sendingData <= sendingData;
        sendingIdle <= sendingIdle;
        escPending <= escPending;
        txCredit <= txCredit;
        valid_o <= 0;
        ackTimecode_o <= 0;
        ackSpaceAvail_o <= 0;
        ackData_o <= 0;
        ackIdle_o <= 0;
        if (txReset) 
          begin
            sendingTimecode <= 0;
            sendingCredit <= 0;
            sendingData <= 0;
            sendingIdle <= 0;
            escPending <= 0;
            txCredit <= 0;
          end
        else 
          begin
            if (~isBusy && ready_i) 
              begin
                if (reqTimecode_i) 
                  begin
                    ackTimecode_o <= 1;
                    sendingTimecode <= 1;
                    escPending <= 1;
                    dat_o <= 9'b1_0000_0011;
                    valid_o <= 1;
                  end
                else if (reqSpaceAvail_i) 
                  begin
                    ackSpaceAvail_o <= 1;
                    sendingCredit <= 1;
                    dat_o <= 9'b1_0000_0000;
                    valid_o <= 1;
                  end
                else if (isValid && haveCredit && reqData_i) 
                  begin
                    ackData_o <= 1;
                    sendingData <= 1;
                    dat_o <= dat_i;
                    valid_o <= 1;
                    txCredit <= txCredit-1;
                  end
                else if (~isValid && reqData_i) 
                  begin
                    ackData_o <= 1;
                  end
                else if (reqIdle_i) 
                  begin
                    ackIdle_o <= 1;
                    sendingIdle <= 1;
                    escPending <= 1;
                    dat_o <= 8'b1_0000_0011;
                    valid_o <= 1;
                  end
                  
              end
            else if (isBusy && ready_i) 
              begin
                if (sendingTimecode && ~sendingIdle && escPending && 
                    (~sendingCredit && ~sendingData)) 
                  begin
                    escPending <= 0;
                    sendingData <= 1;
                    dat_o <= {1'b0,timecode_i};
                    valid_o <= 1;
                  end
                  
                if (sendingTimecode && (~sendingCredit && ~escPending) && 
                    ~sendingIdle && sendingData) 
                  begin
                    sendingTimecode <= 0;
                    sendingData <= 0;
                  end
                  
                if (~sendingTimecode && 
                    (~sendingIdle && ~sendingData && 
(~escPending && sendingCredit))) 
                  begin
                    sendingCredit <= 0;
                  end
                  
                if (~sendingTimecode && sendingIdle && ~sendingCredit && 
                    (escPending && ~sendingData)) 
                  begin
                    escPending <= 0;
                    sendingCredit <= 1;
                    dat_o <= 9'b1_0000_0000;
                    valid_o <= 1;
                  end
                  
                if (~sendingTimecode && (~escPending && sendingIdle) && 
                    ~sendingData && sendingCredit) 
                  begin
                    sendingCredit <= 0;
                    sendingIdle <= 0;
                  end
                  
              end
              
          end
      end
endmodule

