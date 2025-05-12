module RC(
	dout,       
	din,        
	address,    
	size,       
	read_write, 
	enable,     
	pwm,        
	reset,      
	clk         
);
	`include "definition/Definition.v"
	output	reg			[WORD-1:0]								dout;
	input	wire		[WORD-1:0]								din;
	input	wire		[WORD-1:0]								address;
	input	wire		[LOGWORDBYTE-1:0]						size;
	input	wire												read_write;
	input	wire												enable;
	output	wire												pwm;
	input														reset;
	input														clk;
	localparam RCPERIOD = 1*10**6;	
	reg			[WORD-1:0]								periodshadow;
	reg			[WORD-1:0]								periodhold;
	reg			[WORD-1:0]								period;
	reg			[WORD-1:0]								timer;
	assign pwm = (timer < period);
	always @(posedge clk) begin
		if(reset) begin
			periodshadow	<= 0;
			period			<= 0;
			timer			<= 0;
		end
		else begin
			if((enable==ENABLE) && (read_write==WRITE) && (address==0)) begin
				periodshadow	<= din;
			end
			else begin
				periodshadow	<= periodshadow;
			end
			if(timer==RCPERIOD-1+periodhold) begin
				periodhold	<= periodshadow;
				period		<= periodshadow;
				timer		<= 0;
			end
			else begin
				periodhold	<= periodhold;
				period		<= period;
				timer		<= timer+1;
			end
		end
	end
	always @(posedge clk) begin
		if(reset) begin
			dout	<= 0;
		end
		else if((enable==ENABLE) && (read_write==READ) && (address==0)) begin
			dout	<= periodshadow;
		end
		else begin
			dout	<= 0;
		end
	end
endmodule