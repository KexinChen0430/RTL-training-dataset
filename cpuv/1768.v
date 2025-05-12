module regm(
	    input wire 	       clk, 
	    input wire 	       rst, 
	    input wire [4:0]   read1, read2, 
	    output wire [31:0] data1, data2, 
	    input wire 	       regwrite, 
	    input wire [4:0]   wrreg, 
	    input wire [31:0]  wrdata); 