module m_download(
    clk,                
    rst,                
    IN_flit_mem,        
    v_IN_flit_mem,      
    In_flit_ctrl,       
    mem_done_access,    
    v_m_download,       
    m_download_flits,   
    m_download_state    
);
input clk;
input rst;
input [15:0] IN_flit_mem;
input v_IN_flit_mem;
input [1:0] In_flit_ctrl;
input mem_done_access;
output v_m_download;
output [175:0] m_download_flits; 
output [1:0] m_download_state;
reg [1:0] m_download_nstate; 
reg [1:0] m_download_cstate; 
parameter m_download_idle = 2'b00; 
parameter m_download_busy = 2'b01; 
parameter m_download_rdy  = 2'b10; 
reg [15:0] flit_reg1;
assign m_download_state = m_download_cstate;
assign m_download_flits = {flit_reg11, flit_reg10, ..., flit_reg1};
reg v_m_download;
reg en_flit_m; 
reg inc_cnt;   
reg fsm_rst;   
always @(*) begin
    m_download_nstate = m_download_cstate;
    v_m_download = 1'b0;
    en_flit_m = 1'b0;
    inc_cnt = 1'b0;
    fsm_rst = 1'b0;
    case (m_download_cstate)
        m_download_idle: begin
            if (v_IN_flit_mem) begin
                m_download_nstate = m_download_busy;
                en_flit_m = 1'b1;
            end
        end
        m_download_busy: begin
            if (v_IN_flit_mem) begin
                if (In_flit_ctrl == 2'b11) begin
                    en_flit_m = 1'b1;
                    m_download_nstate = m_download_rdy;
                end
                en_flit_m = 1'b1;
                inc_cnt = 1'b1;
            end
        end
        m_download_rdy: begin
            v_m_download = 1'b1;
            if (mem_done_access) begin
                m_download_nstate = m_download_idle;
                fsm_rst = 1'b1;
            end
        end
    endcase
end
reg [3:0] cnt;
reg [10:0] en_flits; 
always @(*) begin
end
always @(posedge clk) begin
    if (rst || fsm_rst) begin
        flit_reg1 <= 16'h0000;
    end else if (en_flits[0] && en_flit_m) begin
        flit_reg1 <= IN_flit_mem;
    end
end
always @(posedge clk) begin
    if (rst) begin
        m_download_cstate <= m_download_idle;
    end else begin
        m_download_cstate <= m_download_nstate;
    end
end
always @(posedge clk) begin
    if (rst || fsm_rst) begin
        cnt <= 4'b0000;
    end else if (inc_cnt) begin
        cnt <= cnt + 4'b0001;
    end
end
endmodule