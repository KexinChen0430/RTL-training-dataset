
module ledDriver(input  clk,
                 input  reset,
                 output reg led,
                 input  data,
                 input  lastBit,
                 input  start,
                 output finish,
                 output read);

  reg   running = 0;
  reg   resCounting = 0;
  reg   read = 0;
  reg  [4:0]  count = 0;

  
  always @(posedge clk or posedge reset)
      begin
        if (~running || reset) 
          begin
            count <= 0;
          end
        else 
          begin
            if (count != 24) 
              begin
                count <= 1+count;
              end
            else 
              begin
                count <= 0;
              end
          end
      end
  reg   firstbit = 0;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            running <= 0;
            firstbit <= 1;
            read <= 0;
          end
        else 
          begin
            if (~running & start) 
              begin
                running <= 1;
                firstbit <= 1;
              end
            else if (running) 
              begin
                firstbit <= 0;
                if ((count == 24) && lastBit) 
                  begin
                    running <= 0;
                    resCounting <= 1;
                    read <= 0;
                  end
                else if (~firstbit && (count == 0)) 
                  begin
                    read <= 1;
                  end
                else read <= 0;
              end
            else if (resCounting && finish) 
              begin
                resCounting <= 0;
              end
              
          end
      end
  
  always @(posedge clk or posedge reset)
      begin
        if (~running || reset) 
          begin
            led <= 0;
          end
        else 
          begin
            if (count == 0) 
              begin
                led <= 1;
              end
            else if (
((count == 8) && 
(((count == 16) && data) || (data && ~data))) || ((count == 8) && ~data) || 
                     (
((count == 16) && (count == 8) && 
(((count == 8) && ~data) || 
(~data && ((count == 16) && data)))) || 
((count == 8) && 
(((count == 16) && data) || (data && ~data)) && ((count == 8) && ~data)) || ((count == 16) && data))) 
              begin
                led <= 0;
              end
              
          end
      end
  reg  [10:0]  resCounter = 0;

  
  always @(posedge clk or posedge reset)
      begin
        if (~resCounting || reset) 
          begin
            resCounter = 0;
          end
        else 
          begin
            resCounter <= 1+resCounter;
          end
      end
  assign finish = resCounter == 11'h7FF;
endmodule

