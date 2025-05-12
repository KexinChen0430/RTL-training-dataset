module at_the_start; 
	reg clk; 
	reg [6:0] money, price; 
	reg reset, start; 
	always begin 
    	#5 clk <= 0; 
    	#5 clk <= 1; 
    end 
	initial 
	begin
		$display($time, " << Starting the simulation >>"); 
		money = 7'd75; 
		price = 7'd64; 
		reset = 1'b0; 
		start = 1'b1; 
		#50 
		money = 7'd100; 
		price = 7'd54; 
		reset = 1'b0; 
		start = 1'b1; 
		#50 
		money = 7'd50; 
		price = 7'd27; 
		reset = 1'b0; 
		start = 1'b1; 
		#50 
		money = 7'd50; 
		price = 7'd27; 
		reset = 1'b0; 
		start = 1'b1; 
		$display($time, " << Finishing the simulation >>"); 
	end 
endmodule 