module lm32_interrupt (
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
wire [interrupts-1:0] asserted; 
wire [interrupts-1:0] interrupt_n_exception; 
reg ie; 
reg eie; 
`ifdef CFG_DEBUG_ENABLED
reg bie; 
`endif
reg [interrupts-1:0] ip; 
reg [interrupts-1:0] im; 
assign interrupt_n_exception = ip & im;
assign interrupt_exception = (|interrupt_n_exception) & ie;
assign asserted = ip | interrupt;
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
            endcase
        end
    end
    else
    begin
        always @(*)
        begin
            case (csr)
            endcase
        end
    end
endgenerate
generate
    if (interrupts > 1)
    begin
        always @(posedge clk_i `CFG_RESET_SENSITIVITY)
        begin
        end
    end
else
    begin
        always @(posedge clk_i `CFG_RESET_SENSITIVITY)
        begin
        end
    end
endgenerate
endmodule