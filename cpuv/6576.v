module fmlbrg_datamem #( 
	parameter depth = 11 
) (
	input sys_clk, 
	input [depth-1:0] a, 
	input [7:0] we, 
	input [63:0] di, 
	output [63:0] do, 
	input [depth-1:0] a2, 
	output [63:0] do2 
);
reg [7:0] ram0[0:(1 << depth)-1]; 
reg [7:0] ram1[0:(1 << depth)-1]; 
reg [7:0] ram2[0:(1 << depth)-1]; 
reg [7:0] ram3[0:(1 << depth)-1]; 
reg [7:0] ram4[0:(1 << depth)-1]; 
reg [7:0] ram5[0:(1 << depth)-1]; 
reg [7:0] ram6[0:(1 << depth)-1]; 
reg [7:0] ram7[0:(1 << depth)-1]; 
wire [7:0] ram0di; 
wire [7:0] ram1di; 
wire [7:0] ram2di; 
wire [7:0] ram3di; 
wire [7:0] ram4di; 
wire [7:0] ram5di; 
wire [7:0] ram6di; 
wire [7:0] ram7di; 
wire [7:0] ram0do; 
wire [7:0] ram1do; 
wire [7:0] ram2do; 
wire [7:0] ram3do; 
wire [7:0] ram4do; 
wire [7:0] ram5do; 
wire [7:0] ram6do; 
wire [7:0] ram7do; 
wire [7:0] ram0do2; 
wire [7:0] ram1do2; 
wire [7:0] ram2do2; 
wire [7:0] ram3do2; 
wire [7:0] ram4do2; 
wire [7:0] ram5do2; 
wire [7:0] ram6do2; 
wire [7:0] ram7do2; 
reg [depth-1:0] a_r; 
reg [depth-1:0] a2_r; 
always @(posedge sys_clk) begin
	a_r <= a; 
	a2_r <= a2; 
end
always @(posedge sys_clk) begin
	if(we[0]) 
		ram0[a] <= ram0di; 
end
assign ram0do = ram0[a_r]; 
assign ram0do2 = ram0[a2_r]; 
assign ram0di = di[7:0]; 
assign ram1di = di[15:8]; 
assign ram2di = di[23:16]; 
assign ram3di = di[31:24]; 
assign ram4di = di[39:32]; 
assign ram5di = di[47:40]; 
assign ram6di = di[55:48]; 
assign ram7di = di[63:56]; 
assign do = {ram7do, ram6do, ram5do, ram4do, ram3do, ram2do, ram1do, ram0do}; 
assign do2 = {ram7do2, ram6do2, ram5do2, ram4do2, ram3do2, ram2do2, ram1do2, ram0do2}; 
endmodule 