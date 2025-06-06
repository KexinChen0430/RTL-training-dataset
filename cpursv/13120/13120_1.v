
module BaudGen(clk,clk_9600,start,rst);

  input  rst;
  input  start;
  input  clk;
  output reg clk_9600;
  reg  [15:0] state;

  
  initial  
  begin
    clk_9600 <= 0;
    state <= 0;
  end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            state <= 0;
          end
        else if (!start || (state == 2812)) 
          begin
            state <= 0;
          end
        else 
          begin
            state <= 16'd1+state;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            clk_9600 <= 0;
          end
        else if (state == 1406) 
          begin
            clk_9600 <= 1;
          end
        else 
          begin
            clk_9600 <= 0;
          end
      end
endmodule

