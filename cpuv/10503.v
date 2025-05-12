module radar_sim_target_axis #
    (
        parameter integer DATA_WIDTH = 32,
        parameter integer C_S_AXIS_TDATA_WIDTH  = 3200
    )
    (
        (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_HIGH" *)
        (* MARK_DEBUG="true" *)
        input wire EN,
        (* MARK_DEBUG="true" *)
        input wire RADAR_ARP_PE,
        (* MARK_DEBUG="true" *)
        input wire RADAR_ACP_PE,
        input wire [DATA_WIDTH-1:0] ACP_CNT_MAX,
        output wire DATA_VALID,
        output reg [DATA_WIDTH-1:0] ACP_POS = 0,
        output reg [C_S_AXIS_TDATA_WIDTH-1:0] BANK = 0,
        (* MARK_DEBUG="true" *)
        output wire DBG_READY,
        (* MARK_DEBUG="true" *)
        output wire DBG_VALID,
        (* MARK_DEBUG="true" *)
        output wire [DATA_WIDTH-1:0] DBG_ACP_CNT,
        input wire  S_AXIS_ACLK,
        input wire  S_AXIS_ARESETN,
        output reg  S_AXIS_TREADY = 0,
        input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] S_AXIS_TDATA,
        input wire  S_AXIS_TLAST,
        input wire  S_AXIS_TVALID
    );
    localparam POS_BIT_CNT = 16;
    reg fast_fwd = 0;
    reg [DATA_WIDTH-1:0] acp_cnt = 0;
    assign DATA_VALID = EN && (acp_cnt == ACP_POS);
    assign DBG_READY = S_AXIS_TREADY;
    assign DBG_VALID = S_AXIS_TVALID;
    assign DBG_ACP_CNT = acp_cnt;
    always @(posedge S_AXIS_ACLK) begin
        if (RADAR_ARP_PE) begin
            if (RADAR_ACP_PE) begin
                acp_cnt <= 1;
            end else begin
                acp_cnt <= 0;
            end
        end else if (RADAR_ACP_PE) begin
            if (acp_cnt < ACP_CNT_MAX - 1) begin
                acp_cnt <= acp_cnt + 1;
            end
        end
    end
    always @(posedge S_AXIS_ACLK) begin
        if (!S_AXIS_ARESETN || !EN) begin
            BANK <= 0;
            ACP_POS <= 0;
            fast_fwd <= 0;
            S_AXIS_TREADY <= 0;
        end else if (EN) begin
            if (RADAR_ARP_PE) begin
                fast_fwd <= 1;
            end
            if (S_AXIS_TREADY && S_AXIS_TVALID) begin
                BANK <= { S_AXIS_TDATA[C_S_AXIS_TDATA_WIDTH-1:POS_BIT_CNT], 16'b0 };
                ACP_POS <= S_AXIS_TDATA[POS_BIT_CNT-1:0];
                S_AXIS_TREADY <= 0;
                if (fast_fwd && S_AXIS_TDATA[POS_BIT_CNT-1:0] == 0) begin
                    fast_fwd <= 0;
                end
           end else begin
               S_AXIS_TREADY <= (acp_cnt != ACP_POS);
           end
       end
    end
endmodule