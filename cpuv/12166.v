module tb_fpga(); 
	reg A, B; 
	wire out; 
	reg [899:0] brbselect; 
	reg [29:0] leftioselect; 
	reg [29:0] bottomioselect; 
	wire [4:0] left, right, top, bottom; 
	wire [2:0] ibl1w, ibr1w; 
	wire [14:0] ibbw, r_1; 
	assign bottom[0] = A; 
	assign out = left[0]; 
	io_block ibl1(leftioselect[5:0], ibl1w, left[0]); 
	io_block ibb1(bottomioselect[5:0], ibbw[2:0], bottom[0]); 
	last_row_routing lrr1(brbselect[179:0], ibl1w, ibr1w, r_1, ibbw); 
	integer k = 5; 
	integer j; 
	initial begin 
		brbselect = 900'b0; 
		leftioselect = 30'b0; 
		bottomioselect = 30'b0; 
		$display("initialized memory"); 
		leftioselect[0] = 1'b1; 
		bottomioselect[1] = 1'b1; 
		$monitor("A = %b, out = %b", A, out); 
			$display ("Current value of k is %d", k); 
			#10 brbselect = 900'b0; brbselect[k] = 1'b1; A = 1'b0; 
			#10 A = 1'b1; 
	end 
endmodule 