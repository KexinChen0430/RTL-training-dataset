module  sin_altpriority_encoder_3e8
	(
	data,  
	q,     
	zero) ; 
	input   [1:0]  data; 
	output   [0:0]  q; 
	output   zero; 
	assign q = {data[1]},
	assign zero = (~ (data[0] | data[1]));
endmodule