module vga_sync #(
    parameter H_TOTAL_WIDTH = 11,
    parameter V_TOTAL_WIDTH = 11,
    parameter POLARITY      = 1'b1,
    parameter H_FRONT       = 56,
    parameter H_SYNC        = 120,
    parameter H_BACK        = 64,
    parameter H_ACT         = 800,
    parameter V_FRONT       = 37,
    parameter V_SYNC        = 6,
    parameter V_BACK        = 23,
    parameter V_ACT         = 600
)(
    input wire                          clock,
    input wire                          aresetn,
    input wire [9:0]                    R_in,
    input wire [9:0]                    G_in,
    input wire [9:0]                    B_in,
    output wire [(H_TOTAL_WIDTH-1):0]   current_x,
    output wire [(V_TOTAL_WIDTH-1):0]   current_y,
    output wire                         ready,
    output wire                         vga_clk,
    output reg [7:0]                    R_out,
    output reg [7:0]                    G_out,
    output reg [7:0]                    B_out,
    output reg                          h_sync,
    output reg                          v_sync,
    output wire                         blank_n,
    output wire                         sync_n
);
localparam  H_BLANK = H_FRONT + H_SYNC + H_BACK;
localparam  H_TOTAL = H_FRONT + H_SYNC + H_BACK + H_ACT;
localparam  V_BLANK = V_FRONT + V_SYNC + V_BACK;
localparam  V_TOTAL = V_FRONT + V_SYNC + V_BACK + V_ACT;
reg [(H_TOTAL_WIDTH-1):0] hor_pos;
reg [(V_TOTAL_WIDTH-1):0] ver_pos;
reg                         is_active_high;
always @(posedge clock) begin
    is_active_high = POLARITY;
end
assign vga_clk = ~clock;
assign current_x = (hor_pos >= H_BLANK) ? hor_pos - H_BLANK : 'd0;
assign current_y = (ver_pos >= V_BLANK) ? ver_pos - V_BLANK : 'd0;
always @(posedge clock or negedge aresetn) begin
    if (~aresetn) begin
        hor_pos <= 'd0;
        h_sync  <= is_active_high ? 1'b0 : 1'b1;
    end else begin
        if (hor_pos < H_TOTAL)             hor_pos <= hor_pos + 1;
        else                               hor_pos <= 0;
        if (hor_pos == H_FRONT-1)          h_sync <= is_active_high ? 1'b1 : 1'b0;
        if (hor_pos == H_FRONT+H_SYNC-1)   h_sync <= is_active_high ? 1'b0 : 1'b1;
    end
end
always @(posedge h_sync or negedge aresetn) begin
    if (~aresetn) begin
        ver_pos <= 'd0;
        v_sync  <= is_active_high ? 1'b0 : 1'b1;
    end else begin
        if (ver_pos < V_TOTAL)             ver_pos <= ver_pos + 1;
        else                               ver_pos <= 0;
        if (ver_pos == V_FRONT-1)          v_sync <= is_active_high ? 1'b1 : 1'b0;
        if (ver_pos == V_FRONT+V_SYNC-1)   v_sync <= is_active_high ? 1'b0 : 1'b1;
    end
end
always @(posedge clock or negedge aresetn) begin
    if (~aresetn) begin
        R_out <= 8'd0;
        B_out <= 8'd0;
        G_out <= 8'd0;
    end else if ((hor_pos < H_BLANK) | (ver_pos < V_BLANK)) begin
        R_out <= 8'd0;
        B_out <= 8'd0;
        G_out <= 8'd0;
    end else begin
        R_out <= R_in[9:2];
        B_out <= B_in[9:2];
        G_out <= G_in[9:2];
    end
end
assign blank_n = ~((hor_pos < H_BLANK) | (ver_pos < V_BLANK));
assign sync_n  = 1'b1;
assign ready   = ((hor_pos >= H_BLANK & hor_pos < H_TOTAL) & (ver_pos >= V_BLANK & ver_pos < V_TOTAL));
endmodule