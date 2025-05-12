module tkr_stop (signal);
	input signal;
	always @(posedge signal) begin
		$display ("BalsaSimulationStop called");
		$stop;
	end
endmodule