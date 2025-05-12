
module dly_signal(clk,indata,outdata);

  parameter  WIDTH = 1;
  input  clk;
  input  [WIDTH+(0-1):0] indata;
  output [WIDTH+(0-1):0] outdata;
  reg  [WIDTH+(0-1):0] outdata,next_outdata;

  
  always @(posedge clk)  outdata = next_outdata;
  
  always @* 
      begin
        #1 ;
        next_outdata = indata;
      end
endmodule

