module upd4990(
	input XTAL, 
	input CS, OE, 
	input CLK, 
	input DATA_IN, 
	input STROBE, 
	output reg TP, 
	output DATA_OUT	
);
	parameter TIME_REG = 48'h892424113000;		
	reg [3:0] COMMAND_SR; 
	wire [51:0] TIME_SR; 
	wire CLKG, STROBEG;		
	assign TIME_SR = { COMMAND_SR, TIME_REG };	
	assign DATA_OUT = 1'b0;	
	assign CLKG = CS & CLK; 
	assign STROBEG = CS & STROBE; 
	initial
		TP = 1'b0; 
	always
		#5000 TP = !TP;		
	always @(posedge CLKG)
	begin
		$stop; 
		if (CS)
		begin
			$display("RTC clocked in data bit '%B'", DATA_IN);		
			COMMAND_SR[2:0] <= COMMAND_SR[3:1]; 
			COMMAND_SR[3] <= DATA_IN; 
		end
	end
	always @(posedge STROBEG)
		if (CS) $display("RTC strobed, data = %H", COMMAND_SR);	
endmodule