module memphy_alt_mem_phy_mux (
    phy_clk_1x,
    reset_phy_clk_1x_n,
    ctl_address,
    ctl_read_req,
    ctl_wdata,
    ctl_write_req,
    ctl_size,
    ctl_be,
    ctl_refresh_req,
    ctl_burstbegin,
    ctl_ready,
    ctl_wdata_req,
    ctl_rdata,
    ctl_rdata_valid,
    ctl_refresh_ack,
    ctl_init_done,
    ctl_usr_mode_rdy,
    local_address,
    local_read_req,
    local_wdata,
    local_write_req,
    local_size,
    local_be,
    local_refresh_req,
    local_burstbegin,
    mux_seq_controller_ready,
    mux_seq_wdata_req,
    seq_mux_address,
    seq_mux_read_req,
    seq_mux_wdata,
    seq_mux_write_req,
    seq_mux_size,
    seq_mux_be,
    seq_mux_refresh_req,
    seq_mux_burstbegin,
    local_autopch_req,
    local_powerdn_req,
    local_self_rfsh_req,
    local_powerdn_ack,
    local_self_rfsh_ack,
    ctl_autopch_req,
    ctl_powerdn_req,
    ctl_self_rfsh_req,
    ctl_powerdn_ack,
    ctl_self_rfsh_ack,
    local_ready,
    local_wdata_req,
    local_init_done,
    local_rdata,
    local_rdata_valid,
    local_refresh_ack
);
parameter LOCAL_IF_AWIDTH       =  26;
parameter LOCAL_IF_DWIDTH       = 256;
parameter LOCAL_BURST_LEN_BITS  =   1;
parameter MEM_IF_DQ_PER_DQS     =   8;
parameter MEM_IF_DWIDTH         =  64;
input wire                                           phy_clk_1x;
input wire                                           reset_phy_clk_1x_n;
input wire                                           ctl_usr_mode_rdy;
input wire [LOCAL_IF_AWIDTH - 1 : 0]                 local_address;
input wire                                           local_read_req;
input wire [LOCAL_IF_DWIDTH - 1 : 0]                 local_wdata;
input wire                                           local_write_req;
input wire [LOCAL_BURST_LEN_BITS - 1 : 0]            local_size;
input wire [(LOCAL_IF_DWIDTH/8) - 1 : 0]             local_be;
input wire                                           local_refresh_req;
input wire                                           local_burstbegin;
input wire [LOCAL_IF_AWIDTH - 1 : 0]                 seq_mux_address;
input wire                                           seq_mux_read_req;
input wire [LOCAL_IF_DWIDTH - 1 : 0]                 seq_mux_wdata;
input wire                                           seq_mux_write_req;
input wire [LOCAL_BURST_LEN_BITS - 1 : 0]            seq_mux_size;
input wire [(LOCAL_IF_DWIDTH/8) - 1:0]               seq_mux_be;
input wire                                           seq_mux_refresh_req;
input wire                                           seq_mux_burstbegin;
output reg [LOCAL_IF_AWIDTH - 1 : 0]                 ctl_address;
output reg                                           ctl_read_req;
output reg [LOCAL_IF_DWIDTH - 1 : 0]                 ctl_wdata;
output reg                                           ctl_write_req;
output reg [LOCAL_BURST_LEN_BITS - 1 : 0]            ctl_size;
output reg [(LOCAL_IF_DWIDTH/8) - 1:0]               ctl_be;
output reg                                           ctl_refresh_req;
output reg                                           ctl_burstbegin;
input wire                                           ctl_ready;
output reg                                           local_ready;
output reg                                           mux_seq_controller_ready;
input wire                                           ctl_wdata_req;
output reg                                           local_wdata_req;
output reg                                           mux_seq_wdata_req;
input wire                                           ctl_init_done;
output reg                                           local_init_done;
input wire [LOCAL_IF_DWIDTH - 1 : 0]                 ctl_rdata;
output reg  [LOCAL_IF_DWIDTH - 1 : 0]                local_rdata;
input wire                                           ctl_rdata_valid;
output reg                                           local_rdata_valid;
input wire                                           ctl_refresh_ack;
output reg                                           local_refresh_ack;
input  wire                                          local_autopch_req;
input  wire                                          local_powerdn_req;
input  wire                                          local_self_rfsh_req;
output reg                                           local_powerdn_ack;
output reg                                           local_self_rfsh_ack;
output reg                                           ctl_autopch_req;
output reg                                           ctl_powerdn_req;
output reg                                           ctl_self_rfsh_req;
input  wire                                          ctl_powerdn_ack;
input  wire                                          ctl_self_rfsh_ack;
wire                                                 local_burstbegin_held;
reg                                                  burstbegin_hold;
always @(posedge phy_clk_1x or negedge reset_phy_clk_1x_n)
begin
    if (reset_phy_clk_1x_n == 1'b0)
        burstbegin_hold <= 1'b0;
    else
    begin
        if (local_ready == 1'b0 && (local_write_req == 1'b1 || local_read_req == 1'b1) && local_burstbegin == 1'b1)
            burstbegin_hold <= 1'b1;
        else if (local_ready == 1'b1 && (local_write_req == 1'b1 || local_read_req == 1'b1))
            burstbegin_hold <= 1'b0;
    end
end
assign local_burstbegin_held = burstbegin_hold || local_burstbegin;
always @*
begin
    if (ctl_usr_mode_rdy == 1'b1)
    begin
        ctl_address            = local_address;
        ctl_read_req           = local_read_req;
        ctl_wdata              = local_wdata;
        ctl_write_req          = local_write_req;
        ctl_size               = local_size;
        ctl_be                 = local_be;
        ctl_refresh_req        = local_refresh_req;
        ctl_burstbegin         = local_burstbegin_held;
        local_ready         = ctl_ready;
        local_wdata_req     = ctl_wdata_req;
        local_init_done     = ctl_init_done;
        local_rdata         = ctl_rdata;
        local_rdata_valid   = ctl_rdata_valid;
        local_refresh_ack   = ctl_refresh_ack;
        mux_seq_controller_ready = 1'b0;
        mux_seq_wdata_req        = 1'b0;
        ctl_autopch_req     = local_autopch_req;
        ctl_powerdn_req     = local_powerdn_req;
        ctl_self_rfsh_req   = local_self_rfsh_req;
        local_powerdn_ack   = ctl_powerdn_ack;
        local_self_rfsh_ack = ctl_self_rfsh_ack;
    end
    else
    begin
        ctl_address            = seq_mux_address;
        ctl_read_req           = seq_mux_read_req;
        ctl_wdata              = seq_mux_wdata;
        ctl_write_req          = seq_mux_write_req;
        ctl_size               = seq_mux_size;
        ctl_be                 = seq_mux_be;
        ctl_refresh_req        = local_refresh_req;
        ctl_burstbegin         = seq_mux_burstbegin;
        local_ready         = 1'b0;
        local_wdata_req     = 1'b0;
        local_init_done     = 1'b0;
        local_rdata         = {LOCAL_IF_DWIDTH{1'b0}};
        local_rdata_valid   = 1'b0;
        local_refresh_ack   = ctl_refresh_ack;
        mux_seq_controller_ready   = ctl_ready;
        mux_seq_wdata_req   = ctl_wdata_req;
        ctl_autopch_req     = 1'b0;
        ctl_powerdn_req     = 1'b0;
        ctl_self_rfsh_req   = local_self_rfsh_req;
        local_powerdn_ack   = 1'b0;
        local_self_rfsh_ack = ctl_self_rfsh_ack;
    end
end
endmodule