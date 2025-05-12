module zap_predecode_coproc #( 
        parameter PHY_REGS = 46 
)
(
        input wire              i_clk, 
        input wire              i_reset, 
        input wire [34:0]       i_instruction, 
        input wire              i_valid, 
        input wire              i_cpsr_ff_t, 
        input wire [4:0]        i_cpsr_ff_mode, 
        input wire              i_irq, 
        input wire              i_fiq, 
        input wire              i_clear_from_writeback, 
        input wire              i_data_stall, 
        input wire              i_clear_from_alu, 
        input wire              i_stall_from_shifter, 
        input wire              i_stall_from_issue, 
        input wire              i_pipeline_dav, 
        input wire              i_copro_done, 
        output reg              o_irq, 
        output reg              o_fiq, 
        output reg [34:0]       o_instruction, 
        output reg              o_valid, 
        output reg              o_stall_from_decode, 
        output reg              o_copro_dav_ff, 
        output reg  [31:0]      o_copro_word_ff 
);