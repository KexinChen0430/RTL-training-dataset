
module delay2x5(datain,dataout,clk);

  input  [((0-1)+1)+1:0] datain;
  output [((0-1)+1)+1:0] dataout;
  wire [((0-1)+1)+1:0] dataout;
  input  clk;
  reg  [((0-1)+1)+1:0] buff0;
  reg  [((0-1)+1)+1:0] buff1;
  reg  [((0-1)+1)+1:0] buff2;
  reg  [((0-1)+1)+1:0] buff3;
  reg  [((0-1)+1)+1:0] buff4;

  assign dataout = buff4;
  
  always @(posedge clk)
      begin
        buff0 <= datain;
        buff1 <= buff0;
        buff2 <= buff1;
        buff3 <= buff2;
        buff4 <= buff3;
      end
endmodule

