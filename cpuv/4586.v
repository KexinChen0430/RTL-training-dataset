module axis_broadcast #
(
    parameter M_COUNT = 4,
    parameter DATA_WIDTH = 8,
    parameter KEEP_ENABLE = (DATA_WIDTH>8),
    parameter KEEP_WIDTH = (DATA_WIDTH/8),
    parameter LAST_ENABLE = 1,
    parameter ID_ENABLE = 0,
    parameter ID_WIDTH = 8,
    parameter DEST_ENABLE = 0,
    parameter DEST_WIDTH = 8,
    parameter USER_ENABLE = 1,
    parameter USER_WIDTH = 1
)
(
    input  wire                          clk,
    input  wire                          rst,
    input  wire [DATA_WIDTH-1:0]         s_axis_tdata,
    input  wire [KEEP_WIDTH-1:0]         s_axis_tkeep,
    input  wire                          s_axis_tvalid,
    output wire                          s_axis_tready,
    input  wire                          s_axis_tlast,
    input  wire [ID_WIDTH-1:0]           s_axis_tid,
    input  wire [DEST_WIDTH-1:0]         s_axis_tdest,
    input  wire [USER_WIDTH-1:0]         s_axis_tuser,
    output wire [M_COUNT*DATA_WIDTH-1:0] m_axis_tdata,
    output wire [M_COUNT*KEEP_WIDTH-1:0] m_axis_tkeep,
    output wire [M_COUNT-1:0]            m_axis_tvalid,
    input  wire [M_COUNT-1:0]            m_axis_tready,
    output wire [M_COUNT-1:0]            m_axis_tlast,
    output wire [M_COUNT*ID_WIDTH-1:0]   m_axis_tid,
    output wire [M_COUNT*DEST_WIDTH-1:0] m_axis_tdest,
    output wire [M_COUNT*USER_WIDTH-1:0] m_axis_tuser
);
parameter CL_M_COUNT = $clog2(M_COUNT);
reg s_axis_tready_reg = 1'b0, s_axis_tready_next;
reg [DATA_WIDTH-1:0] m_axis_tdata_reg  = {DATA_WIDTH{1'b0}};
reg [KEEP_WIDTH-1:0] m_axis_tkeep_reg  = {KEEP_WIDTH{1'b0}};
reg [M_COUNT-1:0]    m_axis_tvalid_reg = {M_COUNT{1'b0}}, m_axis_tvalid_next;
reg                  m_axis_tlast_reg  = 1'b0;
reg [ID_WIDTH-1:0]   m_axis_tid_reg    = {ID_WIDTH{1'b0}};
reg [DEST_WIDTH-1:0] m_axis_tdest_reg  = {DEST_WIDTH{1'b0}};
reg [USER_WIDTH-1:0] m_axis_tuser_reg  = {USER_WIDTH{1'b0}};
reg [DATA_WIDTH-1:0] temp_m_axis_tdata_reg  = {DATA_WIDTH{1'b0}};
reg [KEEP_WIDTH-1:0] temp_m_axis_tkeep_reg  = {KEEP_WIDTH{1'b0}};
reg                  temp_m_axis_tvalid_reg = 1'b0, temp_m_axis_tvalid_next;
reg                  temp_m_axis_tlast_reg  = 1'b0;
reg [ID_WIDTH-1:0]   temp_m_axis_tid_reg    = {ID_WIDTH{1'b0}};
reg [DEST_WIDTH-1:0] temp_m_axis_tdest_reg  = {DEST_WIDTH{1'b0}};
reg [USER_WIDTH-1:0] temp_m_axis_tuser_reg  = {USER_WIDTH{1'b0}};
reg store_axis_input_to_output;
reg store_axis_input_to_temp;
reg store_axis_temp_to_output;
assign s_axis_tready = s_axis_tready_reg;
assign m_axis_tdata  = {M_COUNT{m_axis_tdata_reg}};
assign m_axis_tkeep  = KEEP_ENABLE ? {M_COUNT{m_axis_tkeep_reg}} : {M_COUNT*KEEP_WIDTH{1'b1}};
assign m_axis_tvalid = m_axis_tvalid_reg;
assign m_axis_tlast  = LAST_ENABLE ? {M_COUNT{m_axis_tlast_reg}} : {M_COUNT{1'b1}};
assign m_axis_tid    = ID_ENABLE   ? {M_COUNT{m_axis_tid_reg}}   : {M_COUNT*ID_WIDTH{1'b0}};
assign m_axis_tdest  = DEST_ENABLE ? {M_COUNT{m_axis_tdest_reg}} : {M_COUNT*DEST_WIDTH{1'b0}};
assign m_axis_tuser  = USER_ENABLE ? {M_COUNT{m_axis_tuser_reg}} : {M_COUNT*USER_WIDTH{1'b0}};
wire s_axis_tready_early = ((m_axis_tready & m_axis_tvalid) == m_axis_tvalid) || (!temp_m_axis_tvalid_reg && (!m_axis_tvalid || !s_axis_tvalid));
always @* begin
    m_axis_tvalid_next = m_axis_tvalid_reg & ~m_axis_tready;
    temp_m_axis_tvalid_next = temp_m_axis_tvalid_reg;
    store_axis_input_to_output = 1'b0;
    store_axis_input_to_temp = 1'b0;
    store_axis_temp_to_output = 1'b0;
    if (s_axis_tready_reg) begin
        if (((m_axis_tready & m_axis_tvalid) == m_axis_tvalid) || !m_axis_tvalid) begin
            m_axis_tvalid_next = {M_COUNT{s_axis_tvalid}};
            store_axis_input_to_output = 1'b1;
        end else begin
            temp_m_axis_tvalid_next = s_axis_tvalid;
            store_axis_input_to_temp = 1'b1;
        end
    end else if ((m_axis_tready & m_axis_tvalid) == m_axis_tvalid) begin
        m_axis_tvalid_next = {M_COUNT{temp_m_axis_tvalid_reg}};
        temp_m_axis_tvalid_next = 1'b0;
        store_axis_temp_to_output = 1'b1;
    end
end
always @(posedge clk) begin
    if (rst) begin
        s_axis_tready_reg <= 1'b0;
        m_axis_tvalid_reg <= {M_COUNT{1'b0}};
        temp_m_axis_tvalid_reg <= {M_COUNT{1'b0}};
    end else begin
        s_axis_tready_reg <= s_axis_tready_early;
        m_axis_tvalid_reg <= m_axis_tvalid_next;
        temp_m_axis_tvalid_reg <= temp_m_axis_tvalid_next;
    end
    if (store_axis_input_to_output) begin
        m_axis_tdata_reg <= s_axis_tdata;
        m_axis_tkeep_reg <= s_axis_tkeep;
        m_axis_tlast_reg <= s_axis_tlast;
        m_axis_tid_reg   <= s_axis_tid;
        m_axis_tdest_reg <= s_axis_tdest;
        m_axis_tuser_reg <= s_axis_tuser;
    end else if (store_axis_temp_to_output) begin
        m_axis_tdata_reg <= temp_m_axis_tdata_reg;
        m_axis_tkeep_reg <= temp_m_axis_tkeep_reg;
        m_axis_tlast_reg <= temp_m_axis_tlast_reg;
        m_axis_tid_reg   <= temp_m_axis_tid_reg;
        m_axis_tdest_reg <= temp_m_axis_tdest_reg;
        m_axis_tuser_reg <= temp_m_axis_tuser_reg;
    end
    if (store_axis_input_to_temp) begin
        temp_m_axis_tdata_reg <= s_axis_tdata;
        temp_m_axis_tkeep_reg <= s_axis_tkeep;
        temp_m_axis_tlast_reg <= s_axis_tlast;
        temp_m_axis_tid_reg   <= s_axis_tid;
        temp_m_axis_tdest_reg <= s_axis_tdest;
        temp_m_axis_tuser_reg <= s_axis_tuser;
    end
end
endmodule