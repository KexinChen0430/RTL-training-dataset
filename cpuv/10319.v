module uparc_fast_imul( 
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
assign ready	= 1'b1;		 
assign product	= (signd && (multiplicand[`UPARC_REG_WIDTH-1] ^ multiplier[`UPARC_REG_WIDTH-1])) ? 
			-prod : prod; 
wire [`UPARC_REG_WIDTH-1:0] a = signd && multiplier[`UPARC_REG_WIDTH-1] ? 
	-multiplier : multiplier; 
wire [`UPARC_REG_WIDTH-1:0] b = signd && multiplicand[`UPARC_REG_WIDTH-1] ? 
	-multiplicand : multiplicand; 
wire [2*`UPARC_REG_WIDTH-1:0]	prod = a * b; 
endmodule 