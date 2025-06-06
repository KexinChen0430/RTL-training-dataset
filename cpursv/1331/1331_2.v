
module slaveRxStatusMonitor(connectStateIn,connectStateOut,resumeDetectedIn,
                            resetEventOut,resumeIntOut,clk,rst);

  input  [1:0] connectStateIn;
  input  resumeDetectedIn;
  input  clk;
  input  rst;
  output resetEventOut;
  output [1:0] connectStateOut;
  output resumeIntOut;
  wire [1:0] connectStateIn;
  wire resumeDetectedIn;
  wire clk;
  wire rst;
  reg  resetEventOut;
  reg  [1:0] connectStateOut;
  reg  resumeIntOut;
  reg  [1:0] oldConnectState;
  reg  oldResumeDetected;

  
  always @(connectStateIn)
      begin
        connectStateOut <= connectStateIn;
      end
  
  always @(posedge clk)
      begin
        if (rst == 1'b1) 
          begin
            oldConnectState <= connectStateIn;
            oldResumeDetected <= resumeDetectedIn;
          end
        else 
          begin
            oldConnectState <= connectStateIn;
            oldResumeDetected <= resumeDetectedIn;
            if (oldConnectState != connectStateIn) resetEventOut <= 1'b1;
            else resetEventOut <= 1'b0;
            if ((oldResumeDetected == 1'b0) && 
                (resumeDetectedIn == 1'b1)) resumeIntOut <= 1'b1;
            else resumeIntOut <= 1'b0;
          end
      end
endmodule

