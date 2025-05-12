module altera_irq_bridge  
#(
	parameter IRQ_WIDTH	= 32  
)
(
	(*altera_attribute = "-name MESSAGE_DISABLE 15610" *) 
	input				clk,  
	(*altera_attribute = "-name MESSAGE_DISABLE 15610" *) 
	input				reset,  
	input [IRQ_WIDTH - 1:0]		receiver_irq,  
	output 				sender31_irq,  
);
	wire [31:0]                     receiver_temp_irq;  
	assign receiver_temp_irq = {{(32 - IRQ_WIDTH){1'b0}}, receiver_irq};  
	assign sender0_irq = receiver_temp_irq[0];  
endmodule