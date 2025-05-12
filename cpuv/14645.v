module phase_selector
(
	input CLK400, 
	input CLK80,  
	input reset,  
	input [3:0]phsel, 
	input [7:0]serin, 
	output serout 
);
	reg [7:0]serdel; 
	wire [15:0]ser = {serin, serdel}; 
	always @(posedge CLK400 or posedge reset) 
	begin
		if (reset) serdel <= 0; 
		else serdel <= serin; 
	end
	reg [15:0]pos; 
	always @(posedge CLK80) 
	begin
		case (phsel) 
		endcase
	end
	reg [15:0]stage1; 
	reg [3:0]stage2; 
	reg stage3; 
	always @(posedge CLK400 or posedge reset) 
	begin
		if (reset) 
		begin
			stage1 <= 0; 
			stage2 <= 0; 
			stage3 <= 0; 
		end
		else 
		begin
			stage1 <= ser & pos;  
			stage2 <= {|stage1[15:12], |stage1[11:8], |stage1[7:4], |stage1[3:0]};
			stage3 <= |stage2; 
		end
	end
	assign serout = stage3; 
endmodule