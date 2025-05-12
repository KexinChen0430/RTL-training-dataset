module RegisterTest; 
	Register r1(Bus_in, clk, reset, r_in, r_out, Bus_out); 
	reg Bus_in, clk, reset, r_in, r_out; 
	output Bus_out; 
	initial 
		begin
		$display("\t\t      %5s | %5s | %5s |----| %5s | %5s |", "RESET", "RIN", "ROUT", "BUSIN", "BOUT"); 
		$monitor($time, ": %5b | %5b | %5b |----| %5b | %5b |", reset, r_in, r_out, Bus_in, Bus_out); 
		reset = 1; clk = 1; 
	#10	r_in = 0; r_out = 0; Bus_in = 0;	reset = 0;		
	#10	r_in = 0; r_out = 0; Bus_in = 1;					
	#10	r_in = 1; r_out = 0; Bus_in = 0;					
	#10	r_in = 0; r_out = 1; Bus_in = 0;					
	#10	r_in = 0; r_out = 1; Bus_in = 1;					
	#10	r_in = 1; r_out = 1; Bus_in = 1;					
	#10	r_in = 1; r_out = 1; Bus_in = 0;					
	#10	r_in = 1; r_out = 0; Bus_in = 1;					
	#10	r_in = 0; r_out = 1; Bus_in = 0;					
	#10	r_in = 0; r_out = 1; Bus_in = 1;					
	#10	r_in = 1; r_out = 1; Bus_in = 0;					
		 $finish(); 
	end
	always 
		begin: CLOCKGEN
		#5 clk = ~clk; 
	end
endmodule