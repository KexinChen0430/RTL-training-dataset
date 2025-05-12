
module clk_divider(input  sysclk,
                   output slowclk);

  reg  [6:0] counter;
  reg  slowclock;

  
  initial  
  begin
    counter = 0;
    slowclock = 1;
  end
  
  always @(posedge sysclk)
      begin
        if (counter == 'd50) 
          begin
            counter <= 0;
            slowclock <= ~slowclock;
          end
        else 
          begin
            counter <= 1+counter;
          end
      end
  assign slowclk = slowclock;
endmodule

