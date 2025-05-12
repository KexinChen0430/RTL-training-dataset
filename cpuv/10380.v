module axi_interface(
    input   FCLK_CLK0,
    input   RST_N,
    output  reg [31:0] o_data_to_registers,
    output  reg        o_wr_controll_reg,  
    output  reg        o_wr_data_reg,      
    input   wire [31:0] i_controll_reg,
    input   wire [31:0] i_status_reg,
    input   wire [31:0] i_data_reg,
    input   [31:0]      AXI_araddr,    
    input   [2:0]       AXI_arprot,    
    output  [0:0]       AXI_arready,   
    input   [0:0]       AXI_arvalid,   
    input   [31:0]      AXI_awaddr,    
    input   [2:0]       AXI_awprot,    
    output  [0:0]       AXI_awready,   
    input   [0:0]       AXI_awvalid,   
    input   [0:0]       AXI_bready,    
    output  [1:0]       AXI_bresp,     
    output  [0:0]       AXI_bvalid,    
    output reg [31:0]   AXI_rdata,     
    input   [0:0]       AXI_rready,    
    output  [1:0]       AXI_rresp,     
    output reg [0:0]    AXI_rvalid,    
    input   [31:0]      AXI_wdata,     
    output  [0:0]       AXI_wready,    
    input   [3:0]       AXI_wstrb,     
    input   [0:0]       AXI_wvalid     
    );
wire clk;
assign reset = ~RST_N;
assign clk = FCLK_CLK0;
always @(*) begin
    o_data_to_registers = AXI_wdata[31:0];
end
always @(*) begin
    o_wr_data_reg <= '0;
    o_wr_controll_reg <= '0;
    if (AXI_awvalid[0] & AXI_wvalid[0]) begin
        if(AXI_awaddr[15:2] == `ADDR_CONTROL_REG) 
            o_wr_controll_reg <= '1;
        if(AXI_awaddr[15:2] == `ADDR_DATA_REG) 
            o_wr_data_reg <= '1;
    end
end
assign AXI_awready[0] = AXI_awvalid[0] & AXI_wvalid[0];   
assign AXI_wready[0]  = AXI_awvalid[0] & AXI_wvalid[0];   
assign AXI_bvalid[0]  = AXI_awvalid[0] & AXI_wvalid[0]; 	
assign AXI_bresp = 2'h0;
always @(posedge clk) begin
    AXI_rdata <= '0;
    if (AXI_arvalid[0])
        if(AXI_araddr[15:2] == `ADDR_CONTROL_REG) 
            AXI_rdata <= i_controll_reg;
        if(AXI_araddr[15:2] ==  `ADDR_STATUS_REG) 
            AXI_rdata <= i_status_reg;
        if(AXI_araddr[15:2] == `ADDR_DATA_REG) 
            AXI_rdata <= i_data_reg;
end
always @(posedge clk) begin
    if(reset)
        AXI_rvalid[0] <= 1'b0;
    else if(AXI_arvalid)
        AXI_rvalid[0] <= 1'b1;
    else if(AXI_rready)
        AXI_rvalid[0] <= 1'b0;
end
assign AXI_arready[0] = AXI_arvalid[0];
assign AXI_rresp = 2'h0;
endmodule