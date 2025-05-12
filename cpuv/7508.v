module controller_unit(
    input wire [7:0] opcode, 
    input wire [`FWIDTH - 1:0] flags, 
    input wire clk, 
    input wire res, 
    output wire [1:0] ac_source, 
    output wire write_ac, 
    output wire mar_source, 
    output wire write_mar, 
    output wire [1:0] mdr_source, 
    output wire write_mdr, 
    output wire write_flags, 
    output wire [1:0] pc_source, 
    output wire write_pc, 
    output wire write_ir, 
    output wire write_mem, 
    output wire [2:0] ALU_op_select, 
    output wire [`ALUCTLW - 1:0] ALUctl 
);
wire [`MCROM_WIDTH - 1:0] mc_word; 
wire [`OFFSET_WIDTH - 1:0] offset, rom_offset_next, op_decoder_out; 
wire [1:0] offset_next_select; 
decoder_complex idec0 (
    .opcode(opcode), 
    .flags(flags), 
    .op_decoder_out(op_decoder_out) 
);
microcode_rom rom0 (
    .clk(clk), 
    .offset(offset), 
    .mc_word(mc_word) 
);
mux4 #(.WIDTH(`OFFSET_WIDTH)) mux0(
    .in0(op_decoder_out), 
    .in1(rom_offset_next), 
    .in2(`OFFSET_WIDTH'b0), 
    .in3(`OFFSET_WIDTH'b0), 
    .sel(offset_next_select), 
    .mux_out(offset) 
);
assign offset_next_select = {res, res ? 1'b1 : mc_word[`OFFSET_NEXT_SEL]}; 
assign rom_offset_next = mc_word[`OFFSET_NEXT]; 
assign ac_source = mc_word[`AC_SOURCE]; 
assign write_ac = mc_word[`WRITE_AC]; 
assign mar_source = mc_word[`MAR_SOURCE]; 
assign write_mar = mc_word[`WRITE_MAR]; 
assign mdr_source = mc_word[`MDR_SOURCE]; 
assign write_mdr = mc_word[`WRITE_MDR]; 
assign write_flags = mc_word[`WRITE_FLAGS]; 
assign pc_source = mc_word[`PC_SOURCE]; 
assign write_pc = mc_word[`WRITE_PC]; 
assign write_ir = mc_word[`WRITE_IR]; 
assign write_mem = mc_word[`WRITE_MEM]; 
assign ALU_op_select = mc_word[`ALU_OP_SELECT]; 
assign ALUctl = mc_word[`ALUCTL]; 
endmodule 