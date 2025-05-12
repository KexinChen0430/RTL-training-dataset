module FLIPFLOP ( DIN, RST, CLK, DOUT );
input  DIN;
input  RST;
input  CLK;
output DOUT;
reg DOUT_reg;
always @ ( `OR1200_RST_EVENT RST or posedge CLK ) begin
   if (RST == `OR1200_RST_VALUE)
     DOUT_reg <= 1'b0;
   else
     DOUT_reg <=  DIN;
end
assign DOUT = DOUT_reg;
endmodule