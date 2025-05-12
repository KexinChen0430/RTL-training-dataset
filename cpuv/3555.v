module
	reg d_lrck_1, d_lrck_2, d_lrck_3, d_lrck_4, d_lrck_5, d_lrck_6;
	wire lrck_negedge_flag;
	assign lrck_negedge_flag = (d_lrck_4 ^ d_lrck_6) & ~d_lrck_4;
	always @ (posedge sck or posedge rst_i) begin
		if(rst_i) begin
			d_lrck_1 <= 1'b0;
			d_lrck_2 <= 1'b0;
			d_lrck_3 <= 1'b0;
			d_lrck_5 <= 1'b0;
		end
		else begin
			d_lrck_1 <= lrck_i;
			d_lrck_2 <= d_lrck_1;
			d_lrck_3 <= d_lrck_2;
			d_lrck_5 <= d_lrck_4;
		end
	end
	always @ (negedge sck or posedge rst_i) begin
		if(rst_i) begin
			d_lrck_4 <= 1'b0;
			d_lrck_6 <= 1'b0;
		end
		else begin
			d_lrck_4 <= d_lrck_3;
			d_lrck_6 <= d_lrck_5;
		end
	end
	always @ (negedge d_lrck_4 or posedge rst_i) begin
		if(rst_i) begin
			rst_int <= 1'b1;
		end
		else begin
			if(&bit_cnt[7:0]) begin
				rst_int <= 1'b0;
			end
			else begin
				rst_int <= 1'b1;
			end
		end
	end
	always @ (negedge sck or posedge rst) begin
		if(rst) begin
			bit_cnt <= 9'b111111111;
		end
		else begin
			bit_cnt <= bit_cnt + 1'b1;
		end
	end
	reg [255:0] fifo_a;
	reg [255:0] fifo_b;
	always @ (posedge bck_i or posedge rst) begin
		if(rst) begin
			fifo_a <= 256'b0;
			fifo_b <= 256'b0;
		end
		else begin
			if(!bank) begin
				fifo_a[255-bit_cnt[7:2]] <= dat_i[0];
				fifo_a[191-bit_cnt[7:2]] <= dat_i[1];
				fifo_a[127-bit_cnt[7:2]] <= dat_i[2];
				fifo_a[63-bit_cnt[7:2]] <= dat_i[3];
			end
			else begin
				fifo_b[255-bit_cnt[7:2]] <= dat_i[0];
				fifo_b[191-bit_cnt[7:2]] <= dat_i[1];
				fifo_b[127-bit_cnt[7:2]] <= dat_i[2];
				fifo_b[63-bit_cnt[7:2]] <= dat_i[3];
			end
		end
	end
	always @ (posedge sck or posedge rst) begin
		if(rst) begin
			dat_o <= 1'b0;
		end
		else begin
			if(!bank) begin
				dat_o <= fifo_b[255-bit_cnt[7:0]];
			end
			else begin
				dat_o <= fifo_a[255-bit_cnt[7:0]];
			end
		end
	end
	assign fsync_o = &bit_cnt[7:0];
endmodule