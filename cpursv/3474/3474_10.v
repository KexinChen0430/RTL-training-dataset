
module pipeline_stall(clk,reset,datain,dataout);

  parameter  WIDTH = 1;
  parameter  DELAY = 1;
  input  clk,reset;
  input  [(-1)+WIDTH:0] datain;
  output [(-1)+WIDTH:0] dataout;
  reg  [(-1)+(WIDTH*DELAY):0] dly_datain,next_dly_datain;

  assign dataout = dly_datain[(-1)+(WIDTH*DELAY):(DELAY-1)*WIDTH];
  
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

