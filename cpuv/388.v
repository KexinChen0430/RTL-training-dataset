module decoder_complex(
    input wire [7:0] opcode,                 
    input wire [`FWIDTH - 1 : 0] flags,      
    output reg [`MC_OFFSET_WIDTH - 1 : 0] op_decoder_out  
);
    always @(*) begin
        case(opcode)
            8'h00: op_decoder_out = `MC_OFFSET_WIDTH'h0a;
            8'h01: op_decoder_out = `MC_OFFSET_WIDTH'h08;
            8'h02: op_decoder_out = `MC_OFFSET_WIDTH'h04;
            8'h03: op_decoder_out = `MC_OFFSET_WIDTH'h0e;
            8'h04: op_decoder_out = flags[`NEGATIVE_FLAG] ? `MC_OFFSET_WIDTH'h0e : `MC_OFFSET_WIDTH'h0f;
            8'h05: op_decoder_out = `MC_OFFSET_WIDTH'h16;
            8'h06: op_decoder_out = `MC_OFFSET_WIDTH'h1a;
            8'h07: op_decoder_out = `MC_OFFSET_WIDTH'h1e;
            8'h08: op_decoder_out = `MC_OFFSET_WIDTH'h22;
            8'h09: op_decoder_out = flags[`NEGATIVE_FLAG] ? `MC_OFFSET_WIDTH'h0f : `MC_OFFSET_WIDTH'h0e;
            8'h0a: op_decoder_out = flags[`ZERO_FLAG] ? `MC_OFFSET_WIDTH'h0e : `MC_OFFSET_WIDTH'h0f;
            8'h0b: op_decoder_out = `MC_OFFSET_WIDTH'h26;
            8'h0d: op_decoder_out = `MC_OFFSET_WIDTH'h29;
            8'h0e: op_decoder_out = `MC_OFFSET_WIDTH'h28;
            8'h70: op_decoder_out = flags[`CARRY_FLAG] ? `MC_OFFSET_WIDTH'h0e : `MC_OFFSET_WIDTH'h0f;
            8'h71: op_decoder_out = flags[`OVERFLOW_FLAG] ? `MC_OFFSET_WIDTH'h0e : `MC_OFFSET_WIDTH'h0f;
            8'h72: op_decoder_out = `MC_OFFSET_WIDTH'h10;
            8'h73: op_decoder_out = `MC_OFFSET_WIDTH'h11;
            8'h74: op_decoder_out = `MC_OFFSET_WIDTH'h12;
            8'h75: op_decoder_out = `MC_OFFSET_WIDTH'h27;
            8'h7e: op_decoder_out = `MC_OFFSET_WIDTH'h02;
            8'h7f: op_decoder_out = `MC_OFFSET_WIDTH'h03;
            default: op_decoder_out = {`MC_OFFSET_WIDTH{1'b1}};
        endcase
    end
endmodule