
module cuckooRinging(output buzzer,
                     input  isSameTime,
                     input  clk,
                     input  yoodRong,
                     input  onOffAlarm);

  assign ringAble = !onOffAlarm & isSameTime;
  reg  ringIng;

  
  always @(posedge ringAble or negedge yoodRong)
      begin
        if (ringAble) ringIng <= 1;
        else ringIng <= 0;
        if (!yoodRong) ringIng <= 0;
          
      end
  reg  [12:0]  soundFile = 13'b0000010111111;

  wire  sound = soundFile[0];

  
  always @(posedge clk)
      begin
        soundFile <= {soundFile[11:0],soundFile[12]};
      end
  assign buzzer = ringIng & sound;
endmodule

