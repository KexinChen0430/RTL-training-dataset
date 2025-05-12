
module delay1x37(datain,dataout,clk);

  input  [1-1:0] datain;
  output [1-1:0] dataout;
  wire [1-1:0] dataout;
  input  clk;
  reg  [1-1:0] buff0;
  reg  [1-1:0] buff1;
  reg  [1-1:0] buff2;
  reg  [1-1:0] buff36;

  assign dataout = buff36;
  
  always @(posedge clk)
      begin
        buff0 <= datain;
        buff1 <= buff0;
        buff2 <= buff1;
        buff36 <= buff35;
      end
endmodule

