
module VGAController(input  iClk,
                     input  inRst,
                     input  [7:0] iR,
                     input  [7:0] iG,
                     input  [7:0] iB,
                     output [7:0] oR,
                     output [7:0] oG,
                     output [7:0] oB,
                     output oHSync,
                     output oVSync,
                     output oLineValid,
                     output oFrameValid);

  parameter  H_SYNC_PULSE = 96;
  parameter  H_SYNC_BACK = 48;
  parameter  H_SYNC_DATA = 640;
  parameter  H_SYNC_FRONT = 16;
  parameter 
       H_SYNC_TOTAL = ((H_SYNC_FRONT+H_SYNC_PULSE)+H_SYNC_BACK)+H_SYNC_DATA;
  parameter  V_SYNC_PULSE = 1+1;
  parameter  V_SYNC_BACK = 36;
  parameter  V_SYNC_DATA = 480;
  parameter  V_SYNC_FRONT = 7;
  parameter 
       V_SYNC_TOTAL = (V_SYNC_DATA+V_SYNC_BACK)+(V_SYNC_FRONT+V_SYNC_PULSE);
  parameter 
       H_START_DATA = (H_SYNC_FRONT+H_SYNC_PULSE)+H_SYNC_BACK;
  parameter 
       V_START_DATA = V_SYNC_FRONT+(V_SYNC_PULSE+V_SYNC_BACK);
  parameter  H_STOP_DATA = H_SYNC_DATA+H_START_DATA;
  parameter  V_STOP_DATA = V_START_DATA+V_SYNC_DATA;
  parameter  H_START_PULSE = H_SYNC_FRONT;
  parameter  V_START_PULSE = V_SYNC_FRONT;
  parameter  H_STOP_PULSE = H_SYNC_FRONT+H_SYNC_PULSE;
  parameter  V_STOP_PULSE = V_SYNC_FRONT+V_SYNC_PULSE;
  reg  [12:0]  mHCounter = 0;
  reg  [12:0]  mVCounter = 0;

  assign oVSync = ((mVCounter >= V_START_PULSE) && 
                  (inRst && (mVCounter < V_STOP_PULSE))) ? 0 : 1;
  assign oHSync = (inRst && (mHCounter < H_STOP_PULSE) && 
                  (mHCounter >= H_START_PULSE)) ? 0 : 1;
  assign oFrameValid = ((mVCounter < V_STOP_DATA) && 
                       ((mVCounter >= V_START_DATA) && inRst)) ? 1 : 0;
  assign oLineValid = ((mHCounter < H_STOP_DATA) && oFrameValid && 
                      (mHCounter >= H_START_DATA)) ? 1 : 0;
  assign oR = (oFrameValid && (inRst && oLineValid)) ? iR : 0;
  assign oG = (oFrameValid && (inRst && oLineValid)) ? iG : 0;
  assign oB = (oFrameValid && (inRst && oLineValid)) ? iB : 0;
  
  always @(posedge iClk or negedge inRst)
      begin
        if (~inRst) mHCounter <= 0;
        else 
          begin
            if (mHCounter == (H_SYNC_TOTAL+(0-1))) mHCounter <= 0;
            else mHCounter <= 1+mHCounter;
          end
      end
  
  always @(posedge iClk or negedge inRst)
      begin
        if (~inRst) mVCounter <= 0;
        else 
          begin
            if (mHCounter == (H_SYNC_TOTAL+(0-1))) 
              begin
                if (mVCounter == (V_SYNC_TOTAL-1)) mVCounter <= 0;
                else mVCounter <= mVCounter+1;
              end
              
          end
      end
endmodule

