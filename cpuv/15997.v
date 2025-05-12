module Top (
		input  wire         clock,                  
		input  wire         reset,                  
		input  wire [6:0]   io_S_AVALON_address,    
		output wire [31:0]  io_S_AVALON_readdata,   
		input  wire         io_S_AVALON_chipselect, 
		input  wire         io_S_AVALON_write,      
		input  wire         io_S_AVALON_read,       
		input  wire [31:0]  io_S_AVALON_writedata,  
		output wire [3:0]   io_M_AXI_0_AWID,        
		output wire [31:0]  io_M_AXI_0_AWUSER,      
		output wire [31:0]  io_M_AXI_0_AWADDR,      
		output wire [7:0]   io_M_AXI_0_AWLEN,       
		output wire [2:0]   io_M_AXI_0_AWSIZE,      
		output wire [1:0]   io_M_AXI_0_AWBURST,     
		output wire         io_M_AXI_0_AWLOCK,      
		output wire [3:0]   io_M_AXI_0_AWCACHE,     
		output wire [2:0]   io_M_AXI_0_AWPROT,      
		output wire [3:0]   io_M_AXI_0_AWQOS,       
		output wire         io_M_AXI_0_AWVALID,     
		input  wire         io_M_AXI_0_AWREADY,     
		output wire [3:0]   io_M_AXI_0_ARID,        
		output wire [31:0]  io_M_AXI_0_ARUSER,      
		output wire [31:0]  io_M_AXI_0_ARADDR,      
		output wire [7:0]   io_M_AXI_0_ARLEN,       
		output wire [2:0]   io_M_AXI_0_ARSIZE,      
		output wire [1:0]   io_M_AXI_0_ARBURST,     
		output wire         io_M_AXI_0_ARLOCK,      
		output wire [3:0]   io_M_AXI_0_ARCACHE,     
		output wire [2:0]   io_M_AXI_0_ARPROT,      
		output wire [3:0]   io_M_AXI_0_ARQOS,       
		output wire         io_M_AXI_0_ARVALID,     
		input  wire         io_M_AXI_0_ARREADY,     
		output wire [511:0] io_M_AXI_0_WDATA,       
		output wire [63:0]  io_M_AXI_0_WSTRB,       
		output wire         io_M_AXI_0_WLAST,       
		output wire         io_M_AXI_0_WVALID,      
		input  wire         io_M_AXI_0_WREADY,      
		input  wire [3:0]   io_M_AXI_0_RID,         
		input  wire [31:0]  io_M_AXI_0_RUSER,       
		input  wire [511:0] io_M_AXI_0_RDATA,       
		input  wire [1:0]   io_M_AXI_0_RRESP,       
		input  wire         io_M_AXI_0_RLAST,       
		input  wire         io_M_AXI_0_RVALID,      
		output wire         io_M_AXI_0_RREADY,      
		input  wire [3:0]   io_M_AXI_0_BID,         
		input  wire [31:0]  io_M_AXI_0_BUSER,       
		input  wire [1:0]   io_M_AXI_0_BRESP,       
		input  wire         io_M_AXI_0_BVALID,      
		output wire         io_M_AXI_0_BREADY       
	);
	assign io_S_AVALON_readdata = 32'b00000000000000000000000000000000;
	assign io_M_AXI_0_AWBURST = 2'b00;
	assign io_M_AXI_0_AWUSER = 32'b00000000000000000000000000000000;
	assign io_M_AXI_0_ARLEN = 8'b00000000;
	assign io_M_AXI_0_ARQOS = 4'b0000;
	assign io_M_AXI_0_WSTRB = 64'b0000000000000000000000000000000000000000000000000000000000000000;
	assign io_M_AXI_0_RREADY = 1'b0;
	assign io_M_AXI_0_AWLEN = 8'b00000000;
	assign io_M_AXI_0_AWQOS = 4'b0000;
	assign io_M_AXI_0_ARCACHE = 4'b0000;
	assign io_M_AXI_0_ARADDR = 32'b00000000000000000000000000000000;
	assign io_M_AXI_0_WVALID = 1'b0;
	assign io_M_AXI_0_ARPROT = 3'b000;
	assign io_M_AXI_0_AWPROT = 3'b000;
	assign io_M_AXI_0_ARVALID = 1'b0;
	assign io_M_AXI_0_WDATA = 512'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
	assign io_M_AXI_0_AWCACHE = 4'b0000;
	assign io_M_AXI_0_ARID = 4'b0000;
	assign io_M_AXI_0_ARLOCK = 1'b0;
	assign io_M_AXI_0_AWLOCK = 1'b0;
	assign io_M_AXI_0_AWADDR = 32'b00000000000000000000000000000000;
	assign io_M_AXI_0_ARBURST = 2'b00;
	assign io_M_AXI_0_ARSIZE = 3'b000;
	assign io_M_AXI_0_BREADY = 1'b0;
	assign io_M_AXI_0_WLAST = 1'b0;
	assign io_M_AXI_0_AWID = 4'b0000;
	assign io_M_AXI_0_AWSIZE = 3'b000;
	assign io_M_AXI_0_AWVALID = 1'b0;
	assign io_M_AXI_0_ARUSER = 32'b00000000000000000000000000000000;
endmodule