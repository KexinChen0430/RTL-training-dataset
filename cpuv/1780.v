module at_the_start
	always begin
    	#5 ck = 0;  
    	#5 ck = 1;  
    end
	conv_encoder enc (
		cout,  
		bin,   
		ck,    
		rset   
	);
	initial
	begin
		$display(" << Starting the simulation >>");  
		bin = 1'b0;  
		rset=0;      
		#3;          
		bin = 1'b1;  
		#7;          
		bin = 1'b0;  
		#20;         
		$display(" << Finishing the simulation >>");  
		$finish;  
	end
endmodule