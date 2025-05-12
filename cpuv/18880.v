module array_arith ( 
    ap_clk, 
    ap_rst, 
    ap_start, 
    ap_done, 
    ap_idle, 
    ap_ready, 
    d_address0, 
    d_ce0, 
    d_we0, 
    d_d0, 
    d_q0 
);
parameter    ap_ST_fsm_state1 = 6'd1;
parameter    ap_ST_fsm_state2 = 6'd2;
parameter    ap_ST_fsm_state3 = 6'd4;
parameter    ap_ST_fsm_state4 = 6'd8;
parameter    ap_ST_fsm_state5 = 6'd16;
parameter    ap_ST_fsm_state6 = 6'd32;
input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [2:0] d_address0;
output   d_ce0;
output   d_we0;
output  [31:0] d_d0;
input  [31:0] d_q0;
reg ap_done;
reg ap_idle;
reg ap_ready;
reg[2:0] d_address0;
reg d_ce0;
reg d_we0;
(* fsm_encoding = "none" *) reg   [5:0] ap_CS_fsm; 
wire    ap_CS_fsm_state1;
reg   [31:0] acc; 
wire   [2:0] i_1_fu_61_p2;
reg   [2:0] i_1_reg_94;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [31:0] d_load_reg_105; 
wire    ap_CS_fsm_state4;
wire   [31:0] tmp_2_fu_75_p2;
reg   [31:0] tmp_2_reg_110;
wire    ap_CS_fsm_state5;
reg   [2:0] i_reg_43; 
wire    ap_CS_fsm_state6;
wire   [63:0] tmp_1_fu_67_p1;
wire   [63:0] tmp_3_fu_86_p1;
wire   [0:0] exitcond_fu_55_p2; 
reg   [5:0] ap_NS_fsm; 
initial begin
#0 ap_CS_fsm = 6'd1; 
#0 acc = 32'd0; 
end
always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1; 
    end else begin
        ap_CS_fsm <= ap_NS_fsm; 
    end
end
assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];
assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];
assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];
assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];
assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];
assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];
assign d_d0 = tmp_2_reg_110;
assign exitcond_fu_55_p2 = ((i_reg_43 == 3'd4) ? 1'b1 : 1'b0);
assign i_1_fu_61_p2 = (i_reg_43 + 3'd1);
assign tmp_1_fu_67_p1 = i_1_reg_94;
assign tmp_2_fu_75_p2 = (d_load_reg_105 + acc);
assign tmp_3_fu_86_p1 = i_reg_43;
endmodule