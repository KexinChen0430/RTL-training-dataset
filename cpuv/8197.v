module monitor( 
       input wire 		  clk_i, 
       input wire 		  rst_i, 
       input wire 		  stop_i, 
       input wire 		  sr_wr_i, 
       input wire [`N-1:0] 	  sr_i, 
       input wire 		  reg_wr_i, 
       input wire 		  stall_i, 
       input wire 		  branching_i, 
       input wire [`N-1:0] 	  pc_i, 
       input wire [`N-1:0] 	  pc_next_i, 
       input wire [`REG_NBIT-1:0] reg_wr_n_i, 
       input wire [`N-1:0] 	  reg_wr_data_i, 
       input wire [3:0] 	  mem_wr_sel_i, 
       input wire [`N-1:0] 	  mem_wr_addr_i, 
       input wire [`N-1:0] 	  mem_wr_data_i 
       );
	reg 				  stall1; 
	always @(posedge clk_i) begin 
		if (`KPU_SIM_TRACE >= 1) 
			if (reg_wr_i && !stop_i) 
				$display("KPU: clk %0d: pc = 0x%x: Reg %0d <= 0x%x",
					 ($time / 10) + 1, pc_i, reg_wr_n_i,
					 reg_wr_data_i); 
		if (`KPU_SIM_TRACE >= 4) begin 
			if (rst_i) 
				$display("KPU: clk %0d: pc = 0x%x: Reset",
					 $time / 10, pc_i); 
			if (stop_i) 
				$display("KPU: clk %0d: pc = 0x%x: Stop",
					 $time / 10, pc_i); 
			if (sr_wr_i && !stop_i) 
				$display("KPU: clk %0d: pc = 0x%x: SR <= %b",
					 ($time / 10) + 1, pc_i, sr_i); 
			if (stall_i && !stop_i) 
				$display("KPU: clk %0d: pc = 0x%x: Injecting bubble",
					 $time / 10, pc_i); 
			if (branching_i && !stop_i) 
				$display("KPU: clk %0d: pc = 0x%x: Branching PC <= 0x%x",
					 $time / 10, pc_i, pc_next_i); 
			if (mem_wr_sel_i != 4'h0 && !stop_i) 
				$display("KPU: clk %0d: pc = 0x%x: mem_sel = %b *addr 0x%x <= 0x%x",
					 ($time / 10) + 1, pc_i, mem_wr_sel_i,
					 mem_wr_addr_i << 2, mem_wr_data_i); 
		end
	end 
endmodule 