module mojo_com_test;
	reg clk; 
	reg rst; 
	localparam DATA_SIZE = 1; 
	reg [DATA_SIZE * 8 -1:0] tx_arr; 
	reg [DATA_SIZE * 8 -1:0] rx_arr; 
	assign tx_arr = 8'h01; 
	reg [7:0] tmp_tx_q, tmp_tx_d; 
	reg [0:0] addr_q, addr_d; 
	always @(*) begin 
		addr_d = addr_q + 1; 
		tmp_tx_d = tx_arr[addr_q+:7]; 
		rx_arr[addr_q+:7] = tmp_tx_q; 
	end
	always @(posedge clk) begin 
		if(rst) begin 
			addr_q <= 0; 
			tmp_tx_q <= 0; 
		end else begin
			addr_q <= addr_d; 
			tmp_tx_q <= tmp_tx_d; 
		end
	end
	initial begin 
		clk = 1'b0; 
		rst = 1'b1; 
		repeat(4) #10 clk = ~clk; 
		rst = 1'b0; 
		forever #10 clk = ~clk; 
	end
	initial begin 
		@(negedge rst); 
		repeat(17) @(posedge clk); 
		$finish; 
	end
endmodule