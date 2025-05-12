module ece453(
	clk,
	reset,
	slave_address,
	slave_read,
	slave_write,
	slave_readdata,
	slave_writedata,
	slave_byteenable,
	gpio_inputs,
	gpio_outputs,
	irq_out
);
	input clk;
	input reset;
	input [3:0] slave_address;
	input slave_read;
	input slave_write;
	output wire [31:0] slave_readdata;
	input [31:0] slave_writedata;
	input [3:0] slave_byteenable;
	input [31:0] gpio_inputs;
	output [31:0] gpio_outputs;
	output wire irq_out;
	`include "ece453.vh"
	reg  [31:0] dev_id_r;
	reg  [31:0] gpio_in_r;
	reg  [31:0] gpio_out_r;
	wire  [31:0] gpio_in;
	wire  [31:0] gpio_out;
	assign slave_readdata = ( (slave_address == DEV_ID_ADDR )    && slave_read )	? dev_id_r :
	                        ( (slave_address == GPIO_IN_ADDR )   && slave_read ) 	? gpio_in_r :
	                        ( (slave_address == GPIO_OUT_ADDR )  && slave_read ) 	? gpio_out_r : 32'h00000000;
	assign irq_out = 0;
	assign gpio_outputs = gpio_out_r;
	assign gpio_in		= gpio_inputs;
	assign gpio_out  	= ( (slave_address == GPIO_OUT_ADDR ) 	&& slave_write ) ? slave_writedata : gpio_out_r;
	always @ (posedge clk or posedge reset)
	begin
		if (reset == 1)
		begin
		   dev_id_r	<= 32'hECE45300;
			gpio_in_r	<= 32'h00000000;
			gpio_out_r	<= 32'h00000000;
		end
		else
		begin
		   dev_id_r		<= 32'hECE45300;
			gpio_in_r	<= gpio_in;
			gpio_out_r	<= gpio_out;
		end
	end
endmodule