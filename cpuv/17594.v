module 
always@(posedge clock or negedge reset) begin
	if (reset == 1'b0)
	  mult_en <= 1'b0;
	else if (start)
	  mult_en <= 1'b1;
	else if (ram_select == `NUM_KERNELS -1 & addr == `ADDR_MAX - 1)
	  mult_en <= 1'b0;
	else
	  mult_en <= mult_en;
end 
endmodule 