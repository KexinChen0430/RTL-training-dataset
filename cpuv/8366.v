module register( 
	ridxA, 
	widxA, 
	wdataA, 
	weA, 
	ridxB, 
	widxB, 
	wdataB, 
	weB, 
	clk, 
	reset, 
	rdataA, 
	rdataB 
	);
input wire [4:0] ridxA;	
input wire [4:0] widxA;	
input wire [31:0] wdataA; 
input wire weA;	
input wire [4:0] ridxB;	
input wire [4:0] widxB;	
input wire [31:0] wdataB; 
input wire weB;	
input wire clk;	
input wire reset; 
output wire [31:0] rdataA; 
output wire [31:0] rdataB; 
reg [31:0] mem [31:0]; 
reg [31:0] i; 
task resetReg; 
begin
	for ( i = 0; i < 32; i = i + 1) begin 
		mem[i] = 32'b0; 
	end
end
endtask
task writeB; 
begin
	if (widxB == 32'b0 | !weB) begin 
	end
	else begin 
		mem[widxB] = wdataB; 
	end
end
endtask
task writeA; 
begin
	if (widxA == 32'b0 | !weA) begin 
	end
	else begin 
		mem[widxA] = wdataA; 
	end
end
endtask
initial begin 
	resetReg; 
end
assign rdataA = mem[ridxA]; 
assign rdataB = mem[ridxB]; 
always @ (posedge clk) begin 
	if (reset) begin 
		resetReg; 
	end
	else begin
		if ((widxA == widxB) & weB) begin 
			writeB; 
		end
		else begin 
			writeB; 
			writeA; 
		end
	end
end
endmodule 