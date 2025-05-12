module ram (addr, clk, din, dout, we, test_mem);
	input [7 : 0] din;
	input [15: 0] addr;
	input clk, we;
	output [7 : 0] dout;
	output[7:0] test_mem;
	reg [7:0] memory[65535:0];
	initial
	begin
		memory[16'h0000] <= 8'hbb; 
		memory[16'h0001] <= 8'h05;
		memory[16'h0002] <= 8'hf9; 
		memory[16'h0003] <= 8'hfc; 
		memory[16'h0004] <= 8'h02; 
		memory[16'h0005] <= 8'h00; 
		memory[16'h0006] <= 8'hff; 
		memory[16'h0200] <= 8'hb9;	
		memory[16'h0201] <= 8'h01;	
		memory[16'h0202] <= 8'hba;	
		memory[16'h0203] <= 8'h01;	
		memory[16'h0204] <= 8'h01;	
		memory[16'h0205] <= 8'h52;	
		memory[16'h0206] <= 8'h08;	
		memory[16'h0207] <= 8'h82;	
		memory[16'h0208] <= 8'h01;	
		memory[16'h0209] <= 8'h02;	
		memory[16'h020a] <= 8'h4b; 
		memory[16'h020b] <= 8'he8;	
		memory[16'h020c] <= 8'h02; 
		memory[16'h020d] <= 8'h04;	
		memory[16'h020e] <= 8'hfb;	
	end
	always @(posedge clk)
	begin
		if (we)
			memory[addr] <= din;
	end
	assign dout = memory[addr];
	assign test_mem = memory[16'hfffe];
endmodule