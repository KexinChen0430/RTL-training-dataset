
module FrequencyCounter(input  clk,
                        input  freqin,
                        output [23:0] frequency);

  parameter  SecondCount = 8001800;
  reg  [23:0]  counter = 0;
  reg  [23:0]  freq = 0;
  reg  [23:0]  secondcounter = 0;
  reg   stopin = 0;
  reg   inreseted = 0;

  
  always @(posedge clk)
      begin
        if (secondcounter == SecondCount) 
          begin
            secondcounter <= 0;
            stopin <= 1;
            freq <= 2*counter;
          end
        else if (~stopin) secondcounter <= 1+secondcounter;
          
        if (inreseted) stopin <= 0;
          
      end
  
  always @(negedge freqin)
      begin
        if (~stopin) 
          begin
            counter <= counter+1;
            inreseted <= 0;
          end
        else 
          begin
            counter <= 0;
            inreseted <= 1;
          end
      end
  assign frequency = freq;
endmodule

