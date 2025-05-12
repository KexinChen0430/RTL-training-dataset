module lm32_interrupt (
    clk_i, 
    rst_i, 
    interrupt, 
    stall_x, 
`ifdef CFG_DEBUG_ENABLED
    non_debug_exception, 
    debug_exception, 
`else
    exception, 
`endif
    eret_q_x, 
`ifdef CFG_DEBUG_ENABLED
    bret_q_x, 
`endif
    csr, 
    csr_write_data, 
    csr_write_enable, 
    interrupt_exception, 
    csr_read_data 
);
parameter interrupts = `CFG_INTERRUPTS; 
input clk_i; 
input rst_i; 
input [interrupts-1:0] interrupt; 
input stall_x; 
`ifdef CFG_DEBUG_ENABLED
input non_debug_exception; 
input debug_exception; 
`else
input exception; 
`endif
input eret_q_x; 
`ifdef CFG_DEBUG_ENABLED
input bret_q_x; 
`endif
input [`LM32_CSR_RNG] csr; 
input [`LM32_WORD_RNG] csr_write_data; 
input csr_write_enable; 
output interrupt_exception; 
wire   interrupt_exception; 
output [`LM32_WORD_RNG] csr_read_data; 
reg    [`LM32_WORD_RNG] csr_read_data; 
`ifndef CFG_LEVEL_SENSITIVE_INTERRUPTS
wire [interrupts-1:0] asserted; 
`endif
wire [interrupts-1:0] interrupt_n_exception; 
reg ie; 
reg eie; 
`ifdef CFG_DEBUG_ENABLED
reg bie; 
`endif
`ifdef CFG_LEVEL_SENSITIVE_INTERRUPTS
wire [interrupts-1:0] ip; 
`else
reg [interrupts-1:0] ip; 
`endif
reg [interrupts-1:0] im; 
assign interrupt_n_exception = ip & im;
assign interrupt_exception = (|interrupt_n_exception) & ie;
`ifdef CFG_LEVEL_SENSITIVE_INTERRUPTS
assign ip = interrupt; 
`else
assign asserted = ip | interrupt; 
`endif
assign ie_csr_read_data = {{`LM32_WORD_WIDTH-3{1'b0}},
`ifdef CFG_DEBUG_ENABLED
                           bie,
`else
                           1'b0,
`endif
                           eie,
                           ie
                          };
assign ip_csr_read_data = ip; 
assign im_csr_read_data = im; 
generate
    if (interrupts > 1)
    begin
        always @(*)
        begin
            case (csr)
`ifdef CFG_MMU_ENABLED
                `LM32_CSR_PSW, 
`endif
                `LM32_CSR_IE:  csr_read_data = {{`LM32_WORD_WIDTH-3{1'b0}},
`ifdef CFG_DEBUG_ENABLED
                                                bie,
`else
                                                1'b0,
`endif
                                                eie,
                                                ie
                                               };
                `LM32_CSR_IP:  csr_read_data = ip; 
                `LM32_CSR_IM:  csr_read_data = im; 
                default:       csr_read_data = {`LM32_WORD_WIDTH{1'bx}}; 
            endcase
        end
    end
    else
    begin
        always @(*)
        begin
            case (csr)
                `LM32_CSR_IE:  csr_read_data = {{`LM32_WORD_WIDTH-3{1'b0}},
`ifdef CFG_DEBUG_ENABLED
                                                bie,
`else
                                                1'b0,
`endif
                                                eie,
                                                ie
                                               };
                `LM32_CSR_IP:  csr_read_data = ip; 
                default:       csr_read_data = {`LM32_WORD_WIDTH{1'bx}}; 
            endcase
        end
    end
endgenerate
generate
    if (interrupts > 1)
    begin
        always @(posedge clk_i `CFG_RESET_SENSITIVITY)
        begin
            if (rst_i == `TRUE)
            begin
                ie <= `FALSE; 
                eie <= `FALSE; 
`ifdef CFG_DEBUG_ENABLED
                bie <= `FALSE; 
`endif
                im <= {interrupts{1'b0}}; 
`ifndef CFG_LEVEL_SENSITIVE_INTERRUPTS
                ip <= {interrupts{1'b0}}; 
`endif
            end
            else
            begin
`ifndef CFG_LEVEL_SENSITIVE_INTERRUPTS
                ip <= asserted; 
`endif
`ifdef CFG_DEBUG_ENABLED
                if (non_debug_exception == `TRUE)
                begin
                    eie <= ie;
                    ie <= `FALSE;
                end
                else if (debug_exception == `TRUE)
                begin
                    bie <= ie;
                    ie <= `FALSE;
                end
`else
                if (exception == `TRUE)
                begin
                    eie <= ie;
                    ie <= `FALSE;
                end
`endif
                else if (stall_x == `FALSE)
                begin
                    if (eret_q_x == `TRUE)
                        ie <= eie;
`ifdef CFG_DEBUG_ENABLED
                    else if (bret_q_x == `TRUE)
                        ie <= bie;
`endif
                    else if (csr_write_enable == `TRUE)
                    begin
                        if (   (csr == `LM32_CSR_IE)
`ifdef CFG_MMU_ENABLED
                            || (csr == `LM32_CSR_PSW) 
`endif
                           )
                        begin
                            ie <= csr_write_data[0];
                            eie <= csr_write_data[1];
`ifdef CFG_DEBUG_ENABLED
                            bie <= csr_write_data[2]; 
`endif
                        end
                        if (csr == `LM32_CSR_IM)
                            im <= csr_write_data[interrupts-1:0];
`ifndef CFG_LEVEL_SENSITIVE_INTERRUPTS
                        if (csr == `LM32_CSR_IP)
                            ip <= asserted & ~csr_write_data[interrupts-1:0];
`endif
                    end
                end
            end
        end
    end
else
    begin
        always @(posedge clk_i `CFG_RESET_SENSITIVITY)
        begin
            if (rst_i == `TRUE)
            begin
                ie <= `FALSE; 
                eie <= `FALSE; 
`ifdef CFG_DEBUG_ENABLED
                bie <= `FALSE; 
`endif
`ifndef CFG_LEVEL_SENSITIVE_INTERRUPTS
                ip <= {interrupts{1'b0}}; 
`endif
            end
            else
            begin
`ifndef CFG_LEVEL_SENSITIVE_INTERRUPTS
                ip <= asserted; 
`endif
`ifdef CFG_DEBUG_ENABLED
                if (non_debug_exception == `TRUE)
                begin
                    eie <= ie;
                    ie <= `FALSE;
                end
                else if (debug_exception == `TRUE)
                begin
                    bie <= ie;
                    ie <= `FALSE;
                end
`else
                if (exception == `TRUE)
                begin
                    eie <= ie;
                    ie <= `FALSE;
                end
`endif
                else if (stall_x == `FALSE)
                begin
                    if (eret_q_x == `TRUE)
                        ie <= eie;
`ifdef CFG_DEBUG_ENABLED
                    else if (bret_q_x == `TRUE)
                        ie <= bie;
`endif
                    else if (csr_write_enable == `TRUE)
                    begin
                        if (   (csr == `LM32_CSR_IE)
`ifdef CFG_MMU_ENABLED
                            || (csr == `LM32_CSR_PSW) 
`endif
                           )
                        begin
                            ie <= csr_write_data[0];
                            eie <= csr_write_data[1];
`ifdef CFG_DEBUG_ENABLED
                            bie <= csr_write_data[2]; 
`endif
                        end
`ifndef CFG_LEVEL_SENSITIVE_INTERRUPTS
                        if (csr == `LM32_CSR_IP)
                            ip <= asserted & ~csr_write_data[interrupts-1:0];
`endif
                    end
                end
            end
        end
    end
endgenerate
endmodule 