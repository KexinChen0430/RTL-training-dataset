module adders (
        ap_clk,      
        ap_rst,      
        in1,         
        in2,         
        in3,         
        ap_return    
);
parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_state2 = 2'd2;
input   ap_clk;
input   ap_rst;
input  [31:0] in1;
input  [31:0] in2;
input  [31:0] in3;
output  [31:0] ap_return;
wire   [31:0] tmp1_fu_42_p2; 
reg   [31:0] tmp1_reg_53;    
reg   [1:0] ap_CS_fsm;       
wire    ap_CS_fsm_state1;    
wire    ap_CS_fsm_state2;    
reg   [1:0] ap_NS_fsm;       
initial begin
#0 ap_CS_fsm = 2'd1;
end
always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end
always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        tmp1_reg_53 <= tmp1_fu_42_p2;
    end
end
always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end
assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];
assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];
assign ap_return = (tmp1_reg_53 + in2);
assign tmp1_fu_42_p2 = (in1 + in3);
endmodule