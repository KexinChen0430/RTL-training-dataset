module cipher_fsm (
);
parameter IDLE_e = 3'd0,
          WARMUP_e = 3'd1,
          WAIT_PROC_e = 3'd2,
          PROC_e = 3'd3;
reg [2:0] cur_state_r; 
reg [2:0] next_state_s; 
reg [10:0] cntr_r; 
reg cphr_en_r; 
reg [31:0] dat_r; 
reg [31:0] dat_o; 
always @(*) begin
    next_state_s = cur_state_r;
    case (cur_state_r)
        IDLE_e: begin
            if (init_i)
                next_state_s = WARMUP_e;
            else
                next_state_s = IDLE_e;
        end
        WARMUP_e: begin
            if (cntr_r == 1151)
                next_state_s = WAIT_PROC_e; 
            else
                next_state_s = WARMUP_e; 
        end
        WAIT_PROC_e: begin
            if (proc_i)
                next_state_s = PROC_e;
            else if (init_i) 
                next_state_s = WARMUP_e;
            else
                next_state_s = WAIT_PROC_e; 
        end
        PROC_e: begin
            if (cntr_r == 31)
                next_state_s = WAIT_PROC_e; 
            else
                next_state_s = PROC_e; 
        end
        default: begin
            next_state_s = cur_state_r; 
        end
    endcase
end
always @(posedge clk_i or negedge n_rst_i) begin
    if (!n_rst_i) begin
        cntr_r <= 0; 
        cur_state_r <= IDLE_e; 
        cphr_en_r <= 1'b0; 
        dat_o <= 0; 
        dat_r <= 0; 
    end
    else begin
        cur_state_r <= next_state_s; 
        case (cur_state_r)
            IDLE_e: begin
                if (next_state_s == WARMUP_e) {
                    cphr_en_r <= 1'b1;
                end
            end
            WARMUP_e: begin
                if (next_state_s == WAIT_PROC_e) {
                    cntr_r <= 0;
                    cphr_en_r <= 1'b0;
                end
                else begin
                    cntr_r <= cntr_r + 1;
                end
            end
            WAIT_PROC_e: begin
                if (next_state_s == PROC_e) {
                    cphr_en_r <= 1'b1;
                    dat_r <= dat_i;
                end
                else if (next_state_s == WARMUP_e)
                    cphr_en_r <= 1'b1; 
            end
            PROC_e: begin
                if (next_state_s == WAIT_PROC_e) {
                    cphr_en_r <= 1'b0;
                    cntr_r <= 0;
                end
                else
                    cntr_r <= cntr_r + 1; 
                dat_r <= {1'b0, dat_r[31:1]};
                dat_o <= {bit_out_s, dat_o[31:1]};
            end
        endcase
    end
end
endmodule 