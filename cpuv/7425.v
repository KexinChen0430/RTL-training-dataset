module LAG_pl_free_pool (flits_tail, flits_valid, 
			pl_alloc_status,        
			pl_allocated,           
			pl_empty,               
			clk, rst_n);            
   parameter num_pls_global = 4; 
   parameter num_pls_local  = 4; 
   parameter only_allocate_pl_when_empty = 0; 
   input [num_pls_global-1:0] flits_tail; 
   input [num_pls_global-1:0] flits_valid; 
   input [num_pls_global-1:0] pl_allocated; 
   output [num_pls_global-1:0] pl_alloc_status; 
   input [num_pls_global-1:0]  pl_empty; 
   input  clk, rst_n; 
   logic [num_pls_global-1:0] pl_alloc_status_reg; 
   pl_t fifo_out; 
   fifov_flags_t fifo_flags; 
   logic push; 
   integer i; 
   generate 
	 always@(posedge clk) begin 
	    if (!rst_n) begin 
	       for (i=0; i<num_pls_global; i++) begin:forpls2 
		  pl_alloc_status_reg[i] <= (i<num_pls_local); 
	       end
	    end else begin 
	       for (i=0; i<num_pls_global; i++) begin:forpls 
		    if (pl_allocated[i]) pl_alloc_status_reg[i]<=1'b0; 
	       if (flits_valid[i] && flits_tail[i]) begin 
		  assert (!pl_alloc_status_reg[i]); 
		  pl_alloc_status_reg[i]<=1'b1; 
	       end
	    end 
      end
	 end 
	 if (only_allocate_pl_when_empty) begin 
	    assign pl_alloc_status = pl_alloc_status_reg & pl_empty; 
	 end else begin 
	    assign pl_alloc_status = pl_alloc_status_reg; 
	 end
   endgenerate 
endmodule 