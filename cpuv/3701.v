module \$assume (A, EN); 
input A, EN; 
`ifndef SIMLIB_NOCHECKS
always @* begin
	if (A !== 1'b1 && EN === 1'b1) begin
		$display("Assumption %m failed!");
		$stop;
	end
end
`endif 
endmodule 