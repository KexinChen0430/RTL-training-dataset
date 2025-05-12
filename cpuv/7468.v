module DE0_NANO_SOC_Default(
	output		          		ADC_CONVST,
	output		          		ADC_SCK,
	output		          		ADC_SDI,
	input 		          		ADC_SDO,
	input 		          		FPGA_CLK1_50,
	input 		          		FPGA_CLK2_50,
	input 		          		FPGA_CLK3_50,
`ifdef ENABLE_HPS
`endif 
	input 		     [1:0]		KEY,
	output		     [7:0]		LED,
	input 		     [3:0]		SW,
	inout 		    [35:0]		GPIO_0,
	inout 		    [35:0]		GPIO_1
);
reg  [31:0]	Cont;
assign GPIO_0  		=	36'hzzzzzzzz;
assign GPIO_1  		=	36'hzzzzzzzz;
always@(posedge FPGA_CLK1_50 or negedge KEY[0])
    begin
        if(!KEY[0])
			 Cont	<=	0;
        else
			 Cont	<=	Cont+1;
    end
assign	LED =	KEY[0]? {Cont[25:24],Cont[25:24],Cont[25:24],
                             Cont[25:24],Cont[25:24]}:10'h3ff;
endmodule