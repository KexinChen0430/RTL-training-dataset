module p_source_files_sr (
    ap_clk,
    ap_rst,
    ap_start,
    ap_done,
    ap_continue,
    ap_idle,
    ap_ready,
    p_read,
    ap_return
);
parameter ap_ST_fsm_state1 = 1'd1;
input ap_clk; 
input ap_rst; 
input ap_start; 
output ap_done; 
input ap_continue; 
output ap_idle; 
output ap_ready; 
input [63:0] p_read; 
output [63:0] ap_return; 
reg ap_done;
reg ap_idle;
reg ap_ready;
reg [63:0] ap_return;
reg ap_done_reg; 
(* fsm_encoding = "none" *) reg [0:0] ap_CS_fsm; 
wire ap_CS_fsm_state1; 
reg ap_block_state1; 
reg [63:0] ap_return_preg; 
reg [0:0] ap_NS_fsm; 
initial begin
    #0 ap_done_reg = 1'b0;
    #0 ap_CS_fsm = 1'd1;
    #0 ap_return_preg = 64'd0;
end
always @(posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1; 
    end else begin
        ap_CS_fsm <= ap_NS_fsm; 
    end
end
always @(posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0; 
    end else begin
        if ((1'b1 == ap_continue)) begin
            ap_done_reg <= 1'b0; 
        end else if (((1'b1 == ap_CS_fsm_state1) & ~((1'b0 == ap_start) | (ap_done_reg == 1'b1)))) begin
            ap_done_reg <= 1'b1; 
        end
    end
end
always @(posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_return_preg <= 64'd0; 
    end else begin
        if (((1'b1 == ap_CS_fsm_state1) & ~((1'b0 == ap_start) | (ap_done_reg == 1'b1)))) begin
            ap_return_preg <= p_read; 
        end
    end
end
always @(*) begin
    if (((1'b1 == ap_CS_fsm_state1) & ~((1'b0 == ap_start) | (ap_done_reg == 1'b1)))) begin
        ap_done = 1'b1; 
    end else begin
        ap_done = ap_done_reg; 
    end
end
always @(*) begin
    if (((1'b0 == ap_start) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1; 
    end else begin
        ap_idle = 1'b0; 
    end
end
always @(*) begin
    if (((1'b1 == ap_CS_fsm_state1) & ~((1'b0 == ap_start) | (ap_done_reg == 1'b1)))) begin
        ap_ready = 1'b1; 
    end else begin
        ap_ready = 1'b0; 
    end
end
always @(*) begin
    if (((1'b1 == ap_CS_fsm_state1) & ~((1'b0 == ap_start) | (ap_done_reg == 1'b1)))) begin
        ap_return = p_read; 
    end else begin
        ap_return = ap_return_preg; 
    end
end
always @(*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state1; 
        end
        default : begin
            ap_NS_fsm = 'bx; 
        end
    endcase
end
assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];
always @(*) begin
    ap_block_state1 = ((1'b0 == ap_start) | (ap_done_reg == 1'b1)); 
end
endmodule