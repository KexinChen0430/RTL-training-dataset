
module ddr_inbuf(clk,pad,indata,indata180);

  parameter  WIDTH = 32;
  input  clk;
  input  [(-1)+WIDTH:0] pad;
  output [(-1)+WIDTH:0] indata;
  output [(-1)+WIDTH:0] indata180;
  reg  [(-1)+WIDTH:0] indata,indata180,next_indata;

  
  always @(posedge clk)  indata = next_indata;
  
  always @(negedge clk)  indata180 = next_indata;
  
  always @* 
      begin
        #1 ;
        next_indata = pad;
      end
endmodule

