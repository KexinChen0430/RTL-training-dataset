
module delay16x16(datain,dataout,clk);

  input  [(0-1)+16:0] datain;
  output [(0-1)+16:0] dataout;
  wire [(0-1)+16:0] dataout;
  input  clk;
  reg  [(0-1)+16:0] buff0;
  reg  [(0-1)+16:0] buff1;
  reg  [(0-1)+16:0] buff2;
  reg  [(0-1)+16:0] buff3;
  reg  [(0-1)+16:0] buff4;
  reg  [(0-1)+16:0] buff5;
  reg  [(0-1)+16:0] buff6;
  reg  [(0-1)+16:0] buff7;
  reg  [(0-1)+16:0] buff8;
  reg  [(0-1)+16:0] buff9;
  reg  [(0-1)+16:0] buff10;
  reg  [(0-1)+16:0] buff11;
  reg  [(0-1)+16:0] buff12;
  reg  [(0-1)+16:0] buff13;
  reg  [(0-1)+16:0] buff14;
  reg  [(0-1)+16:0] buff15;

  assign dataout = buff15;
  
  always @(posedge clk)
      begin
        buff0 <= datain;
        buff1 <= buff0;
        buff2 <= buff1;
        buff3 <= buff2;
        buff4 <= buff3;
        buff5 <= buff4;
        buff6 <= buff5;
        buff7 <= buff6;
        buff8 <= buff7;
        buff9 <= buff8;
        buff10 <= buff9;
        buff11 <= buff10;
        buff12 <= buff11;
        buff13 <= buff12;
        buff14 <= buff13;
        buff15 <= buff14;
      end
endmodule

