module hpdmc_ctlif #(
	parameter csr_addr = 1'b0 
) (
	input sys_clk, 
	input sys_rst, 
	input      [ 2:0] csr_a, 
	input             csr_we, 
	input      [15:0] csr_di, 
	output reg [15:0] csr_do, 
	output reg bypass, 
	output reg sdram_rst, 
	output reg        sdram_cke, 
	output reg        sdram_cs_n, 
	output reg        sdram_we_n, 
	output reg        sdram_cas_n, 
	output reg        sdram_ras_n, 
	output reg [11:0] sdram_adr, 
	output     [ 1:0] sdram_ba, 
	output reg [2:0] tim_rp, 
	output reg [2:0] tim_rcd, 
	output reg tim_cas, 
	output reg [10:0] tim_refi, 
	output reg [3:0] tim_rfc, 
	output reg [1:0] tim_wr 
);
wire csr_selected = csr_a[2] == csr_addr;
assign sdram_ba = 2'b00;
always @(posedge sys_clk) begin
	if(sys_rst) begin 
		csr_do <= 32'd0;
		bypass <= 1'b1;
		sdram_rst <= 1'b1;
		sdram_cke <= 1'b0;
		sdram_adr <= 13'd0;
		tim_rp <= 3'd2;
		tim_rcd <= 3'd2;
		tim_cas <= 1'b0;
		tim_refi <= 11'd740;
		tim_rfc <= 4'd8;
		tim_wr <= 2'd2;
	end else begin 
		sdram_cs_n <= 1'b1;
		sdram_we_n <= 1'b1;
		sdram_cas_n <= 1'b1;
		sdram_ras_n <= 1'b1;
		csr_do <= 32'd0;
		if(csr_selected) begin 
			if(csr_we) begin 
				case(csr_a[1:0])
					2'b00: begin
						bypass <= csr_di[0];
						sdram_rst <= csr_di[1];
						sdram_cke <= csr_di[2];
					end
					2'b01: begin
						sdram_cs_n <= ~csr_di[0];
						sdram_we_n <= ~csr_di[1];
						sdram_cas_n <= ~csr_di[2];
						sdram_ras_n <= ~csr_di[3];
						sdram_adr <= csr_di[15:4];
					end
					2'b10: begin
						tim_rp <= csr_di[2:0];
						tim_rcd <= csr_di[5:3];
						tim_cas <= csr_di[6];
						tim_rfc <= csr_di[10:7];
						tim_wr <= csr_di[12:11];
					end
					2'b11: begin
						tim_refi <= csr_di[10:0];
					end
				endcase
			end
			case(csr_a[1:0])
				2'b00: csr_do <= {sdram_cke, sdram_rst, bypass};
				2'b01: csr_do <= {sdram_adr, 4'h0};
				2'b10: csr_do <= {tim_wr, tim_rfc, tim_cas, tim_rcd, tim_rp};
				2'b11: csr_do <= {5'd0, tim_refi};
			endcase
		end
	end
end
endmodule