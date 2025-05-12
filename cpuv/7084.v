module
	assign rd_data =
	(r_rd_addr >= 8) ? ~(11'b0) :
	data[r_rd_addr];
endmodule