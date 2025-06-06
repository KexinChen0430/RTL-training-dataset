
module dimmer(clock_50,clr_n,up_n,down_n,test,mode,leds);

  input  clock_50;
  input  clr_n;
  input  up_n;
  input  down_n;
  input  test;
  input  mode;
  output [9:0] leds;
  reg  [3:0] scale;
  reg  buttonpressed;
  reg  nextbuttonpressed;
  reg  [4:0] stepcounter;
  reg  [4:0] nextstepcounter;
  reg  [17:0] cyclecounter;
  reg  [25:0] upbuttoncounter;
  reg  [25:0] downbuttoncounter;

  
  always @(negedge up_n or negedge down_n)
      begin
        if (up_n == 0) 
          begin
            nextbuttonpressed <= 1;
          end
        else if (down_n == 0) 
          begin
            nextbuttonpressed <= 1;
          end
        else 
          begin
            nextbuttonpressed <= 0;
          end
      end
  
  always @(upbuttoncounter or downbuttoncounter)
      begin
        if ((upbuttoncounter == 0) && (buttonpressed && !up_n)) 
          begin
            nextstepcounter <= (stepcounter < 4'd15) ? (4'b1+stepcounter) : stepcounter;
          end
        else if (buttonpressed && (downbuttoncounter == 0) && !down_n) 
          begin
            nextstepcounter <= (stepcounter > 0) ? (stepcounter-4'b1) : stepcounter;
          end
        else 
          begin
            nextstepcounter <= stepcounter;
          end
      end
  
  always @(posedge clock_50 or negedge clr_n)
      begin
        if (clr_n == 0) 
          begin
            cyclecounter <= 0;
            stepcounter <= 0;
            buttonpressed <= 0;
            upbuttoncounter <= 0;
            downbuttoncounter <= 0;
          end
        else 
          begin
            scale <= test ? 4'b1010 : 1'b1;
            stepcounter <= nextstepcounter;
            buttonpressed <= nextbuttonpressed;
            cyclecounter <= cyclecounter+13'b1;
            if (cyclecounter >= ((1/scale)*250000)) 
              begin
                cyclecounter <= 0;
              end
              
            if ((upbuttoncounter >= ((1/scale)*50000000)) || 
                (up_n == 1)) 
              begin
                upbuttoncounter <= 0;
              end
            else 
              begin
                upbuttoncounter <= 18'b1+upbuttoncounter;
              end
            if ((downbuttoncounter >= ((1/scale)*50000000)) || 
                (down_n == 1)) 
              begin
                downbuttoncounter <= 0;
              end
            else 
              begin
                downbuttoncounter <= downbuttoncounter+18'b1;
              end
          end
      end
  assign leds = (cyclecounter < ((1/scale)*(stepcounter*15625))) ? 10'b1111111111 : 10'b0;
endmodule

