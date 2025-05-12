module attiny26dip20(data, ale, write, read, zif);
	inout [7:0] data;
	input ale;
	input write;
	input read;
	inout [48:1] zif;
	reg [7:0] address;
	reg [7:0] read_data;
	wire read_oe;
	reg dut_oe;
	reg dut_wr;
	reg dut_xtal;
	reg dut_pagel_bs1;
	reg dut_xa0, dut_xa1_bs2;
	reg [7:0] dut_data;
	reg dut_vpp_en;
	reg dut_vpp;
	reg dut_vcc_en;
	reg dut_vcc;
	wire low, high;
	assign low = 0;
	assign high = 1;
	initial begin
		address <= 0;
		read_data <= 0;
		dut_oe <= 0;
		dut_wr <= 0;
		dut_xtal <= 0;
		dut_pagel_bs1 <= 0;
		dut_xa0 <= 0;
		dut_xa1_bs2 <= 0;
		dut_data <= 0;
		dut_vpp_en <= 0;
		dut_vpp <= 0;
		dut_vcc_en <= 0;
		dut_vcc <= 0;
	end
	always @(negedge ale) begin
		address <= data;
	end
	always @(posedge write) begin
		case (address)
		8'h10: begin
			dut_data <= data;
		end
		8'h11: begin 
			dut_vpp_en <= data[0];
			dut_vpp <= data[1];
			dut_vcc_en <= data[2];
			dut_vcc <= data[3];
		end
		8'h12: begin
			case (data[6:0])
			1: begin
			end
			2: begin
				dut_oe <= data[7];
			end
			3: begin
				dut_wr <= data[7];
			end
			4, 9: begin
				dut_pagel_bs1 <= data[7];
			end
			5: begin
				dut_xa0 <= data[7];
			end
			6, 10: begin
				dut_xa1_bs2 <= data[7];
			end
			7: begin
				dut_xtal <= data[7];
			end
			8: begin
			end
			endcase
		end
		endcase
	end
	always @(negedge read) begin
		case (address)
		8'h10: begin
			read_data[0] <= zif[21];
			read_data[1] <= zif[20];
			read_data[2] <= zif[19];
			read_data[3] <= zif[18];
			read_data[4] <= zif[15];
			read_data[5] <= zif[14];
			read_data[6] <= zif[13];
			read_data[7] <= zif[12];
		end
		8'h12: begin
			read_data[0] <= zif[36];	
			read_data[7:1] <= 0;		
		end
		8'hFD: read_data <= `RUNTIME_ID & 16'hFF; 
		8'hFE: read_data <= (`RUNTIME_ID >> 8) & 16'hFF; 
		8'hFF: read_data <= `RUNTIME_REV; 
		endcase
	end
	assign read_oe = !read && address[4];
	bufif0(zif[1], low, low);
	bufif0(zif[48], low, low);
	bufif1(data[0], read_data[0], read_oe);
	bufif1(data[7], read_data[7], read_oe);
endmodule