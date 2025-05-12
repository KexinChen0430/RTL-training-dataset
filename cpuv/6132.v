module forward ( 
	rt_addr_IDEX, 
	rs_addr_IDEX, 
	rd_addr_EXMEM, 
	rd_addr_MEMWB, 
	regwrite_EXMEM, 
	regwrite_MEMWB, 
	forwardA, 
	forwardB); 
   input [4:0] rt_addr_IDEX; 
   input [4:0] rs_addr_IDEX; 
   input [4:0] rd_addr_EXMEM; 
   input [4:0] rd_addr_MEMWB; 
   input regwrite_EXMEM; 
   input regwrite_MEMWB; 
   output [1:0] forwardA; 
   output [1:0] forwardB; 
endmodule 