
module adc_timeout(input  clk,
                   input  reset,
                   input  sync,
                   input  [15:0] len,
                   output [15:0] size,
                   input  start,
                   input  stop,
                   output reg running);

  reg  [15:0] cnt;
  wire  timeout = cnt == len;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) running <= 0;
        else if (sync) 
          begin
            if (timeout || stop) running <= 0;
            else if (start) running <= 1;
              
          end
          
      end
  
  always @(posedge clk or posedge reset)
      begin
        if (reset) cnt <= 0;
        else if (sync) 
          begin
            if (running) cnt <= 1+cnt;
            else if (start) cnt <= 0;
              
          end
          
      end
  assign size = cnt;
endmodule

