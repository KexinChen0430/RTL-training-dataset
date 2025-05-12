module registers_memory
	#(
	parameter B=32, 
				 W=5	 
	)
	(
		input wire clk,	
		input wire reset, 
		input wire wr_en,	
		input wire [W-1:0] w_addr, r_addr1, r_addr2,
		input wire [B-1:0] w_data,
		output wire [B-1:0] r_data1, r_data2,
		output wire [B-1:0] reg_0, 
		output wire [B-1:0] reg_31
   );
	reg [B-1:0] array_reg [0:31]; 
	integer i; 
	always @(negedge clk,posedge reset)
	begin
			if (reset) 
				begin
					for (i=0;i<32;i=i+1) 
					begin
						array_reg[i] <= 0; 
					end
				end
			else if (wr_en) 
				array_reg[w_addr] <= w_data; 
	end
	assign r_data1 = array_reg[r_addr1]; 
	assign r_data2 = array_reg[r_addr2]; 
	assign reg_0 = array_reg[0]; 
	assign reg_31 = array_reg[31];
endmodule