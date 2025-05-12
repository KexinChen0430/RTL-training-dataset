module int_ctrl( 
		input wire 		   clk_i, 
		input wire 		   rst_i, 
		input wire [`IO_INT_N-1:0] io_int_i, 
		output reg 		   io_int_o, 
		output reg [`N-1:0] 	   int_num_o 
		);
	initial begin 
		io_int_o  <= 1'b0; 
		int_num_o <= `N'h0; 
	end
	always @(posedge clk_i) begin 
		if (rst_i) begin 
			io_int_o  <= 1'b0; 
			int_num_o <= `N'h0; 
		end
		else if (!io_int_o && io_int_i != `IO_INT_N'h0) begin 
			io_int_o <= 1'b1; 
			if (io_int_i[0])
				int_num_o <= `N'h0;
 			else if (io_int_i[1])
				int_num_o <= `N'h1;
 			else if (io_int_i[2])
				int_num_o <= `N'h2;
			else if (io_int_i[3])
				int_num_o <= `N'h3;
			else if (io_int_i[4])
				int_num_o <= `N'h4;
			else if (io_int_i[5])
				int_num_o <= `N'h5;
			else if (io_int_i[6])
				int_num_o <= `N'h6;
			else if (io_int_i[7])
				int_num_o <= `N'h7;
			else if (io_int_i[8])
				int_num_o <= `N'h8;
			else if (io_int_i[9])
				int_num_o <= `N'h9;
			else if (io_int_i[10])
				int_num_o <= `N'ha;
			else if (io_int_i[11])
				int_num_o <= `N'hb;
			else if (io_int_i[12])
				int_num_o <= `N'hc;
			else if (io_int_i[13])
				int_num_o <= `N'hd;
			else if (io_int_i[14])
				int_num_o <= `N'he;
			else if (io_int_i[15])
				int_num_o <= `N'hf;
		end
	end
endmodule 