module ram_sync_nolatch_2r2w(
			     input 			       clk,
			     input [BRAM_ADDR_WIDTH-1:0]       raddr1,
			     input [BRAM_ADDR_WIDTH-1:0]       raddr2,
			     output wire [BRAM_DATA_WIDTH-1:0] rdata1,
			     output wire [BRAM_DATA_WIDTH-1:0] rdata2,
			     input [BRAM_ADDR_WIDTH-1:0]       waddr1,
			     input [BRAM_ADDR_WIDTH-1:0]       waddr2,
			     input [BRAM_DATA_WIDTH-1:0]       wdata1,
			     input [BRAM_DATA_WIDTH-1:0]       wdata2,
			     input 			       we1,
			     input 			       we2
			     );
   parameter BRAM_ADDR_WIDTH = `ADDR_LEN;
   parameter BRAM_DATA_WIDTH = `DATA_LEN;
   parameter DATA_DEPTH      = 32;
   reg [BRAM_DATA_WIDTH-1:0] 				       mem [0:DATA_DEPTH-1];
   assign rdata1 = mem[raddr1];
   assign rdata2 = mem[raddr2];
   always @ (posedge clk) begin
      if (we1)
	mem[waddr1] <= wdata1;
      if (we2)
	mem[waddr2] <= wdata2;
   end
endmodule