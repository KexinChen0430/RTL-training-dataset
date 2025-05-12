
module SoundCtrlChannel1(input  wire iClock,
                         input  wire iReset,
                         input  wire iOsc64,
                         input  wire iOsc256,
                         input  wire iOsc128,
                         input  wire iOsc262k,
                         input  wire [7:0] iNR10,
                         input  wire [7:0] iNR11,
                         input  wire [7:0] iNR12,
                         input  wire [7:0] iNR13,
                         input  wire [7:0] iNR14,
                         output reg [4:0] oOut,
                         output wire oOnFlag);

  reg  [1<<<1:0] rSweepShifts;
  reg  rSweepMode;
  reg  [1<<<1:0] rSweepTime;
  reg  [17:0] rSweepCounter;
  reg  [11:0] rSoundFrequencyNew;
  reg  [5:0] rLength;
  reg  [19:0] rLengthCounter;
  reg  [1:0] rDutyCycle;
  reg  rTimedMode;
  reg  rLengthComplete;
  reg  rTone;
  reg  [10:0] rSoundFrequency;
  reg  [10:0] rSoundFrequencyCounter;
  reg  [3:0] rStep;
  reg  [18:0] rStepTime;
  reg  [18:0] rStepCounter;
  reg  [3:0] rInitialValue;
  reg  rEvelopeMode;
  wire [4:0] up_value,down_value;

  
  always @(posedge iClock)
      begin
        if (iNR14[7] || iReset) 
          begin

          end
          
      end
  
  always @(posedge iOsc64)  begin

  end
  
  always @(posedge iOsc262k)  begin

  end
  
  always @(posedge iOsc128)  begin

  end
  
  always @(posedge iOsc256)  begin

  end
  assign up_value = 5'd15+rStep;
  assign down_value = (0-rStep)+5'd15;
  
  always @(posedge iClock)  begin

  end
  assign oOnFlag = rLengthComplete;
endmodule

