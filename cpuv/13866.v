module TwoComp_SignMag (  
	magnitude,  
	sign,  
	value  
);
	`include "definition/Definition.v"  
	output		reg		[WORD-1:0]	magnitude;  
	output		reg		sign;  
	input				[WORD-1:0]	value;  
	always @(*) begin  
		if(!value[WORD-1])	begin	sign		<=	1'b1;	magnitude	<=	value;	end  
		else				begin	sign		<=	1'b1;	magnitude	<=	-value;	end  
	end
endmodule  