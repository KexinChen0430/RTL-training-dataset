module irq_arb( 
	clk, 
	rst, 
	req, 
	gnt  
);
	input clk; 
	input rst; 
	input [`irqNum - 1: 0] req; 
	output [`irqBit - 1: 0] gnt; 
	parameter grant0 = `irqBit'h0, 
	          grant1 = `irqBit'h1, 
	          grant2 = `irqBit'h2, 
	          grant3 = `irqBit'h3; 
	reg [`irqBit - 1: 0] state = 0, next_state = 0; 
	assign gnt = state; 
	always@(posedge clk or posedge rst) 
		if(rst)	state <= #1 grant0; 
		else	state <= #1 next_state; 
	always@(state or req ) begin 
		next_state = state; 
		case(state) 
	 	   grant0: 
			if(!req[0] ) 
			   begin
				if(req[1])	next_state = grant1; 
				else if(req[2])	next_state = grant2; 
				else if(req[3])	next_state = grant3; 
			   end
	 	   grant1: 
			if(!req[1] ) begin 
				if(req[2])	next_state = grant2; 
				else if(req[3])	next_state = grant3; 
				else if(req[0])	next_state = grant0; 
			end
	 	   grant2: 
			if(!req[2] ) begin 
				if(req[3])	next_state = grant3; 
				else if(req[0])	next_state = grant0; 
				else if(req[1])	next_state = grant1; 
			end
	 	   grant3: 
			if(!req[3] ) begin 
				if(req[0])	next_state = grant0; 
				else if(req[1])	next_state = grant1; 
				else if(req[2])	next_state = grant2; 
			end
		endcase 
	end 
endmodule 