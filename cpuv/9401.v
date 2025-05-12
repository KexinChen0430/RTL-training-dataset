module rzrp(
	input clk_sys,       
	input imask,         
	input irq,           
	input w,             
	input rz_c,          
	input rz_r,          
	input rp_c,          
	input prio_in,       
	output rz,           
	output sz,           
	output rp,           
	output prio_out      
);
	assign sz = rz & imask;
	always @ (posedge clk_sys, posedge irq) begin
		if (irq) rz <= 1'b1;           
		else if (rz_r) rz <= 1'b0;     
		else if (rz_c) case ({w, rp})  
			2'b00 : rz <= rz;          
			2'b01 : rz <= 1'b0;        
			2'b10 : rz <= 1'b1;        
			2'b11 : rz <= ~rz;         
		endcase
	end
	always @ (posedge clk_sys, posedge prio_in) begin
		if (prio_in) rp <= 1'b0;       
		else if (rp_c) rp <= sz;       
	end
	assign prio_out = rp | prio_in;
endmodule 