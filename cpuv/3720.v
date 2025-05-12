module RAMB16_S9(
    CLK,    
    ADDR,   
    DI,     
    DIP,    
    DO,     
    DOP,    
    EN,     
    SSR,    
    WE      
);
input CLK, EN, SSR, WE;
input [10:0] ADDR;
input [7:0] DI;
input DIP;
output [7:0] DO;
output DOP;
parameter WRITE_MODE = 0;
wire [10:0] #1 dly_ADDR = ADDR;
wire [8:0] #1 dly_DATA = {DIP,DI};
wire #1 dly_EN = EN;
wire #1 dly_WE = WE;
reg [8:0] mem[0:2047]; 
reg [7:0] DO;
reg DOP;
reg sampled_EN;
reg [8:0] rddata;
integer i;
initial
begin
  for (i=0; i<2048; i=i+1) mem[i] = 9'h15A;
end
always @(posedge CLK)
begin
  if (dly_EN && dly_WE) mem[dly_ADDR] = dly_DATA;
  rddata = mem[dly_ADDR];
  sampled_EN = dly_EN;
  #1;
  if (sampled_EN) {DOP,DO} = rddata;
end
endmodule