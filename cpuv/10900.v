module radar_statistics # 
(
    parameter DATA_WIDTH = 32 
)
(
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_HIGH" *) 
    input RST, 
    input RADAR_ARP_PE, 
    input RADAR_ACP_PE, 
    input RADAR_TRIG_PE, 
    input wire USEC_PE, 
    input S_AXIS_ACLK, 
    output CALIBRATED, 
    (* MARK_DEBUG="true" *) 
    output reg [DATA_WIDTH-1:0] RADAR_ARP_US = 0, 
    (* MARK_DEBUG="true" *) 
    output reg [DATA_WIDTH-1:0] RADAR_ACP_CNT = 0, 
    (* MARK_DEBUG="true" *) 
    output reg [DATA_WIDTH-1:0] RADAR_TRIG_US = 0 
);
reg [DATA_WIDTH-1:0] arp_us_tmp = 0; 
reg [DATA_WIDTH-1:0] arp_us_max = 0; 
reg [DATA_WIDTH-1:0] acp_cnt_tmp = 0; 
reg [DATA_WIDTH-1:0] acp_cnt_max = 0; 
reg [DATA_WIDTH-1:0] trig_us_tmp = 0; 
reg [DATA_WIDTH-1:0] trig_us_max = 0; 
reg [DATA_WIDTH-1:0] arp_sample_count = 0; 
reg [DATA_WIDTH-1:0] acp_sample_count = 0; 
reg [DATA_WIDTH-1:0] trig_sample_count = 0; 
assign CALIBRATED = (arp_sample_count > 7) && (acp_sample_count > 7) && (trig_sample_count > 7); 
always @(posedge S_AXIS_ACLK) begin 
    if (arp_us_max < arp_us_tmp) begin 
        arp_us_max <= arp_us_tmp; 
    end
    if (acp_cnt_max < acp_cnt_tmp) begin 
        acp_cnt_max <= acp_cnt_tmp; 
    end
    if (trig_us_max < trig_us_tmp) begin 
        trig_us_max <= trig_us_tmp; 
    end
end
always @(posedge S_AXIS_ACLK) begin 
    if (CALIBRATED) begin 
        RADAR_ARP_US <= arp_us_max; 
        RADAR_ACP_CNT <= acp_cnt_max; 
        RADAR_TRIG_US <= trig_us_max; 
    end
end
always @(posedge S_AXIS_ACLK) begin 
    if (RST) begin 
        arp_sample_count <= 0; 
    end else if (RADAR_ARP_PE) begin 
        arp_sample_count <= arp_sample_count + 1; 
        if (USEC_PE) begin 
            arp_us_tmp <= 1; 
        end else begin
            arp_us_tmp <= 0; 
        end
    end else if (USEC_PE) begin 
        arp_us_tmp <= arp_us_tmp + 1; 
    end
end
always @(posedge S_AXIS_ACLK) begin 
     if (RST) begin 
        acp_sample_count <= 0; 
     end else if (RADAR_ARP_PE) begin 
        acp_sample_count <= acp_sample_count + 1; 
        if (RADAR_ACP_PE) begin 
            acp_cnt_tmp <= 1; 
        end else begin
            acp_cnt_tmp <= 0; 
        end
    end else if (RADAR_ACP_PE) begin 
        acp_cnt_tmp <= acp_cnt_tmp + 1; 
    end
end
always @(posedge S_AXIS_ACLK) begin 
    if (RST) begin 
        trig_sample_count <= 0; 
    end else if (RADAR_TRIG_PE) begin 
        trig_sample_count <= trig_sample_count + 1; 
        if (USEC_PE) begin 
            trig_us_tmp <= 1; 
        end else begin
            trig_us_tmp <= 0; 
        end
    end else if (USEC_PE) begin 
        trig_us_tmp <= trig_us_tmp + 1; 
    end
end
endmodule 