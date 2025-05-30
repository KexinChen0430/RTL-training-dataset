module dmac_src_mm_axi #(
  parameter ID_WIDTH = 3,
  parameter DMA_DATA_WIDTH = 64,
  parameter DMA_ADDR_WIDTH = 32,
  parameter BYTES_PER_BEAT_WIDTH = 3,
  parameter BEATS_PER_BURST_WIDTH = 4,
  parameter AXI_LENGTH_WIDTH = 8)(
  input                           m_axi_aclk,
  input                           m_axi_aresetn,
  input                           req_valid,
  output                          req_ready,
  input [DMA_ADDR_WIDTH-1:BYTES_PER_BEAT_WIDTH] req_address,
  input [BEATS_PER_BURST_WIDTH-1:0] req_last_burst_length,
  input                           enable,
  output reg                      enabled = 1'b0,
  output                             bl_valid,
  input                              bl_ready,
  output [BEATS_PER_BURST_WIDTH-1:0] measured_last_burst_length,
  input  [ID_WIDTH-1:0]         request_id,
  output [ID_WIDTH-1:0]         response_id,
  output [ID_WIDTH-1:0]         data_id,
  output [ID_WIDTH-1:0]         address_id,
  input                           address_eot,
  output                          fifo_valid,
  output [DMA_DATA_WIDTH-1:0]   fifo_data,
  output                          fifo_last,
  input                            m_axi_arready,
  output                           m_axi_arvalid,
  output [DMA_ADDR_WIDTH-1:0]      m_axi_araddr,
  output [AXI_LENGTH_WIDTH-1:0]    m_axi_arlen,
  output [ 2:0]                    m_axi_arsize,
  output [ 1:0]                    m_axi_arburst,
  output [ 2:0]                    m_axi_arprot,
  output [ 3:0]                    m_axi_arcache,
  input  [DMA_DATA_WIDTH-1:0]    m_axi_rdata,
  output                           m_axi_rready,
  input                            m_axi_rvalid,
  input                            m_axi_rlast,
  input  [ 1:0]                    m_axi_rresp
);
`include "inc_id.vh"
reg [ID_WIDTH-1:0] id = 'h00;
wire address_enabled;
wire req_ready_ag;
wire req_valid_ag;
wire bl_ready_ag;
wire bl_valid_ag;
assign data_id = id;
assign response_id = id;
assign measured_last_burst_length = req_last_burst_length;
splitter #(
  .NUM_M(3)
) i_req_splitter (
  .clk(m_axi_aclk),
  .resetn(m_axi_aresetn),
  .s_valid(req_valid),
  .s_ready(req_ready),
  .m_valid({
    bl_valid,
    bl_valid_ag,
    req_valid_ag
  }),
  .m_ready({
    bl_ready,
    bl_ready_ag,
    req_ready_ag
  })
);
dmac_address_generator #(
  .ID_WIDTH(ID_WIDTH),
  .BEATS_PER_BURST_WIDTH(BEATS_PER_BURST_WIDTH),
  .BYTES_PER_BEAT_WIDTH(BYTES_PER_BEAT_WIDTH),
  .DMA_DATA_WIDTH(DMA_DATA_WIDTH),
  .LENGTH_WIDTH(AXI_LENGTH_WIDTH),
  .DMA_ADDR_WIDTH(DMA_ADDR_WIDTH)
) i_addr_gen (
  .clk(m_axi_aclk),
  .resetn(m_axi_aresetn),
  .enable(enable),
  .enabled(address_enabled),
  .request_id(request_id),
  .id(address_id),
  .req_valid(req_valid_ag),
  .req_ready(req_ready_ag),
  .req_address(req_address),
  .bl_valid(bl_valid_ag),
  .bl_ready(bl_ready_ag),
  .measured_last_burst_length(req_last_burst_length),
  .eot(address_eot),
  .addr_ready(m_axi_arready),
  .addr_valid(m_axi_arvalid),
  .addr(m_axi_araddr),
  .len(m_axi_arlen),
  .size(m_axi_arsize),
  .burst(m_axi_arburst),
  .prot(m_axi_arprot),
  .cache(m_axi_arcache)
);
assign fifo_valid = m_axi_rvalid;
assign fifo_data = m_axi_rdata;
assign fifo_last = m_axi_rlast;
always @(posedge m_axi_aclk) begin
  if (m_axi_aresetn == 1'b0) begin
    id <= 'h00;
  end else if (m_axi_rvalid == 1'b1 && m_axi_rlast == 1'b1) begin
    id <= inc_id(id);
  end
end
assign m_axi_rready = 1'b1;
always @(posedge m_axi_aclk) begin
  if (m_axi_aresetn == 1'b0) begin
    enabled <= 1'b0;
  end else if (address_enabled == 1'b1) begin
    enabled <= 1'b1;
  end else if (id == address_id) begin
    enabled <= 1'b0;
  end
end
endmodule