module instance to look at different look-up table.
defparam serLut.LOOKUP_ID=1;
defparam parLut.LOOKUP_ID=2;
initial begin
	$display("\tTime\tState Ser\tState Par");
	$monitor("\t%d\t%b\t%b",$time, stateSer, statePar);
end
initial begin
	#0 clk=0; 
	n_clk_cnts=1'b0; 
end
initial begin
	#10 
	for (n_clk_cnts=14'b1001110001000; n_clk_cnts>=14'b1010011010; n_clk_cnts=n_clk_cnts-1'b1) begin
		#2; 
	end
	for (n_clk_cnts=14'b1010011010; n_clk_cnts<=14'b1001110001000; n_clk_cnts=n_clk_cnts+1'b1) begin
		#2; 
	end
	#5 $finish; 
end
always begin
	#1
	clk=~clk; 
end
endmodule