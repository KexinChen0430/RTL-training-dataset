module irq_ctrl(clk, rst_, data, addr, cs_, oe_, we_, irpts, cpu_int, cpu_int_ack); 
	input clk; 
	input rst_; 
	inout [7:0] data; 
	input [7:0] addr; 
	input cs_; 
	input oe_; 
	input we_; 
	input [31:0] irpts; 
	output reg cpu_int; 
	input cpu_int_ack; 
	reg [31:0] irq_mask = 32'd0; 
	reg [4:0] sirq_num = 5'd0; 
	reg sirq = 0; 
	assign data = (~cs_ & ~oe_) ?
					((addr == 0) ? { sirq, 2'b0, sirq_num } :
					((addr == 4) ? irq_mask[7:0] :
					((addr == 5) ? irq_mask[15:8] :
					((addr == 6) ? irq_mask[23:16] :
					((addr == 7) ? irq_mask[31:24] : 8'b0))))) : 8'bzzzzzzzz;
	always @(posedge clk)
		if(~sirq)
			casez (irpts & irq_mask)
				default: { cpu_int, sirq, sirq_num } <= { 1'b0, 1'b0, 5'd0 }; 
			endcase
		else if(cpu_int_ack) cpu_int <= 0; 
		else if(~cs_ & ~we_ & addr == 8'd8) { cpu_int, sirq } <= { 1'b0, 1'b0 }; 
		else sirq <= 1'b1; 
	always @(posedge clk)
		if(~cs_ & ~we_)
			case (addr)
				8'd4: irq_mask[7:0] <= data;
				8'd5: irq_mask[15:8] <= data;
				8'd6: irq_mask[23:16] <= data;
				8'd7: irq_mask[31:24] <= data;
			endcase
endmodule