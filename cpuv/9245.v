module Register (
	value,          
	memory,         
	datapath,       
	sel_memory,     
	sel_datapath,   
	clk,            
	reset           
);
	`include "definition/Definition.v"
	output		reg		[WORD-1:0]								value;	
	input				[WORD-1:0]								memory;
	input				[WORD-1:0]								datapath;
	input														sel_memory;
	input														sel_datapath;
	input														clk;
	input														reset;
	always @(posedge clk) begin
		if(reset)				begin	value	<= 0;			end
		else if(sel_memory)		begin	value	<= memory;		end
		else if(sel_datapath)	begin	value	<= datapath;	end
		else					begin	value	<= value;		end
	end
endmodule