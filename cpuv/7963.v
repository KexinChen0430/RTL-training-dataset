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
    reg	[71:0]	window[7:0]; 
`else
reg	[71:0]	window[7:0]; 
`endif
reg	[71:0]	onereg; 
reg	[2:0]	rd_addr; 
reg	[2:0]	wr_addr; 
reg		save_d; 
`ifdef FPGA_SYN_ALTERA 
    integer k; 
    initial 
    begin
        for (k = 0; k < 8 ; k = k + 1) 
        begin
            window[k] = 72'h0; 
        end
    end
`endif
  initial 
      begin
          onereg = 72'b0; 
          wr_addr = 3'h0; 
          rd_addr = 3'h0; 
      end
  always @(negedge clk) begin 
    rd_addr = restore_addr; 
  end
  always @(posedge clk) begin 
    wr_addr <= save_addr; 
  end
  always @(posedge clk) begin 
    save_d <= save; 
  end
  assign rd_data = onereg; 
  wire [71:0] restore_data = window[rd_addr]; 
  wire [71:0] wrdata = restore ? restore_data : wr_data; 
  wire wr_en = wren | (restore & (wr_addr != rd_addr)); 
  always @(posedge clk) begin 
    if(wr_en) onereg <= wrdata; 
  end
  always @(negedge clk) begin 
    if(save_d) window[wr_addr] <= rd_data; 
  end
endmodule 