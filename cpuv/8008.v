module bw_r_irf_register(clk, wren, save, save_addr, restore, restore_addr, wr_data, rd_data);
	input		clk; 
	input		wren; 
	input		save; 
	input	[2:0]	save_addr; 
	input		restore; 
	input	[2:0]	restore_addr; 
	input	[71:0]	wr_data; 
	output	[71:0]	rd_data; 
`ifdef FPGA_SYN_ALTERA
    reg	[35:0]	window[15:0]; 
`else
    reg	[35:0]	window[15:0];
`endif
    reg	[71:0]	onereg;
    initial onereg = 72'h0;
    assign rd_data = onereg;
    reg [71:0] restore_data;
    wire [71:0] wrdata = restore ? restore_data : wr_data;
    wire wr_en = wren | restore;
    always @(posedge clk) begin
        if(wr_en) onereg <= wrdata;
    end
    wire [2:0] addr = save ? save_addr : restore_addr;
    wire [3:0] addr1 = {1'b1, addr};
    wire [3:0] addr0 = {1'b0, addr};
    always @(negedge clk) begin
        if(save) window[addr1] <= wren ? wr_data[71:36] : rd_data[71:36];
        else restore_data[71:36] <= window[addr1];
    end
    always @(negedge clk) begin
        if(save) window[addr0] <= wren ? wr_data[35:0] : rd_data[35:0];
        else restore_data[35:0] <= window[addr0];
    end
endmodule