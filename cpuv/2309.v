module dataMem(opcode,Rt,addr,clk,out); 
input [5:0] opcode; 
input [31:0] addr, Rt; 
input clk; 
output [31:0] out; 
reg [31:0] memdata [255:0]; 
initial begin
    memdata[0] = 32'b00000000000000000000000000000000;
    memdata[19] = 32'b00000000000000000000000000000000;
end
assign out = memdata[addr];
always @(negedge clk)
begin
    if(opcode==6'b101011)
    begin
        memdata[addr] = Rt;
    end
end
endmodule