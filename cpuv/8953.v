module at_the_start; 
	always begin 
		#5 clk = 0; 
		#5 clk = 1; 
	end
	initial 
	begin
		$display(" << Starting the simulation >>"); 
		ip = 1'd0; 
		rst = 1'd0; 
		#9 ip = 1'd1; rst = 1'd0;
		#10 ip = 1'd0; rst = 1'd0;
		#10 ip = 1'd1; rst = 1'd0;
		#10 ip = 1'd0; rst = 1'd0;
		#10 ip = 1'd1; rst = 1'd0;
		#20; 
		$display(" << Finishing the simulation >>"); 
		$finish; 
	end
endmodule 