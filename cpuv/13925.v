module DM(clk,addr,re,we,wrt_data,rd_data); 
input clk; 
input [15:0] addr; 
input re; 
input we; 
input [15:0] wrt_data; 
output reg [15:0] rd_data; 
reg [15:0]data_mem[0:65535]; 
always @(addr,re,clk) 
  if (~clk && re && ~we) 
    rd_data <= data_mem[addr]; 
always @(addr,we,clk) 
  if (~clk && we && ~re) 
    data_mem[addr] <= wrt_data; 
endmodule 