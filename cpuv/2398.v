module inverter (in, out); 
	parameter DELAY=`inv_delay; 
	input in; 
	output out; 
	reg __o; 
	wire out = __o; 
	always @(in) 
	begin
		#DELAY __o <= ~in; 
	end
endmodule 