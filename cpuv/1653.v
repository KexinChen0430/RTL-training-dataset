module dff(q,data,clk,reset,en) 
	output q; 
	input data,clk,reset,en; 
	reg q; 
	always@(posedge clk)
		begin
			if(reset)		q<=0; 
			else		if(en)	q<=data; 
			else 	q<=q; 
		end
endmodule 