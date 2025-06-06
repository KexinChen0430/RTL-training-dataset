
module wdt(clk,ena,cnt,out);

  input  clk,ena,cnt;
  output out;
  reg  [6:0] timer;
  wire  timer_top = timer == 7'd127;
  reg  internal_enable;
  wire  out = timer_top && internal_enable;

  
  always @(posedge clk)
      begin
        if (ena) 
          begin
            internal_enable <= 1;
            timer <= 0;
          end
        else if (!timer_top && cnt) timer <= 7'd1+timer;
          
      end
endmodule

