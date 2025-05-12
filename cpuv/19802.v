module GP_POR(output reg RST_DONE);
	parameter POR_TIME = 500;
	initial begin
		RST_DONE = 0;
		if(POR_TIME == 4)
			#4000; 
		else if(POR_TIME == 500)
			#500000; 
		else begin
			$display("ERROR: bad POR_TIME for GP_POR cell");
			$finish;
		end
		RST_DONE = 1;
	end
endmodule