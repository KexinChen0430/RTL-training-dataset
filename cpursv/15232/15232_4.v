
module timer(counter,duration,clk);

  input  clk;
  input  [3:0] duration;
  output reg [3:0] counter;
  reg  [25:0] ticker;
  parameter  tick_count = 49999999;

  
  initial  
  begin
    ticker <= tick_count;
    counter <= duration;
  end
  
  always @(posedge clk)
      begin
        if (counter == 0) 
          begin
            ticker <= tick_count;
            counter <= duration;
          end
          
        ticker <= (-1)+ticker;
        if (ticker == 0) counter <= counter+(-1);
          
      end
endmodule

