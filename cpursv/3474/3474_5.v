
module pipeline_stall(clk,reset,datain,dataout);

  parameter  WIDTH = 1;
  parameter  DELAY = 1;
  input  clk,reset;
  input  [WIDTH+(0-1):0] datain;
  output [WIDTH+(0-1):0] dataout;
  reg  [(0-1)+(DELAY*WIDTH):0] dly_datain,next_dly_datain;

  assign dataout = dly_datain[(0-1)+(DELAY*WIDTH):WIDTH*((0-1)+DELAY)];
  
  initial    dly_datain = 0;
  
  always @(posedge clk or posedge reset)
      begin
        if (reset) dly_datain = 0;
        else dly_datain = next_dly_datain;
      end
  
  always @* 
      begin
        #1 ;
        next_dly_datain = {dly_datain,datain};
      end
endmodule

