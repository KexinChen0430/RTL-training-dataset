module mmu_out_dram (
	data_ram,
	mem_op,
	nibble,
	unaligned,
	data_read);
   input [31:0] data_ram;
   input [5:0] mem_op;
   input [1:0] nibble;
   input unaligned;
   output [31:0] data_read;
endmodule