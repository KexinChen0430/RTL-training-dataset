
module dly_signal(clk,indata,outdata);

  parameter  WIDTH = 1;
  input  clk;
  input  [(-1)+WIDTH:0] indata;
  output [(-1)+WIDTH:0] outdata;
  reg  [(-1)+WIDTH:0] outdata,next_outdata;

  
  always @(posedge clk)  outdata = next_outdata;
  
  always @* 
      begin
        #1 ;
        next_outdata = indata;
      end
endmodule

