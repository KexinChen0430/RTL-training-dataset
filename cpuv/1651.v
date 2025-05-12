module uparc_long_imul(
	clk,                
	nrst,               
	multiplicand,       
	multiplier,         
	start,              
	signd,              
	ready,              
	product             
);
input wire				clk;
input wire				nrst;
input wire [`UPARC_REG_WIDTH-1:0]	multiplicand;
input wire [`UPARC_REG_WIDTH-1:0]	multiplier;
input wire				start;
input wire				signd;
output wire				ready;
output wire [2*`UPARC_REG_WIDTH-1:0]	product;
reg [5:0]			nbit;               
reg [2*`UPARC_REG_WIDTH-1:0]	prod;       
reg [`UPARC_REG_WIDTH-1:0]	abs_multiplicand; 
assign ready	= !nbit && !start;
assign product	= (signd && (multiplicand[`UPARC_REG_WIDTH-1] ^ multiplier[`UPARC_REG_WIDTH-1])) ?
			-prod : prod;
always @(posedge clk or negedge nrst)
begin
	if(!nrst) 
	begin
		nbit <= 6'b0; 
		prod <= {(2*`UPARC_REG_WIDTH){1'b0}}; 
		abs_multiplicand <= {(`UPARC_REG_WIDTH){1'b0}}; 
	end
	else if(start) 
	begin
		if(!multiplicand || !multiplier) 
		begin
			nbit <= 6'b0; 
			prod <= {(2*`UPARC_REG_WIDTH){1'b0}}; 
		end
		else 
		begin
			nbit <= 6'd`UPARC_REG_WIDTH; 
			prod <= { {(`UPARC_REG_WIDTH){1'b0}}, signd && multiplier[`UPARC_REG_WIDTH-1] ?
					-multiplier : multiplier };
			abs_multiplicand <= signd && multiplicand[`UPARC_REG_WIDTH-1] ?
					-multiplicand : multiplicand;
		end
	end
	else if(nbit) 
	begin
		nbit <= nbit - 1'b1; 
		if(prod[0]) 
		begin
			prod[2*`UPARC_REG_WIDTH-1:`UPARC_REG_WIDTH-1] <=
					prod[2*`UPARC_REG_WIDTH-1:`UPARC_REG_WIDTH] + abs_multiplicand;
			prod[`UPARC_REG_WIDTH-2:0] <= prod[`UPARC_REG_WIDTH-1:1];
		end
		else 
			prod <= { 1'b0, prod[2*`UPARC_REG_WIDTH-1:1] };
	end
end
endmodule