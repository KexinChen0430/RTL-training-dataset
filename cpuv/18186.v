module altor32_lfu
(
    input [7:0]         opcode_i ,
    input [31:0]        mem_result_i ,
    input [1:0]         mem_offset_i ,
    output reg [31:0]   load_result_o ,
    output reg          load_insn_o 
);
always @ *
begin
    load_result_o   = 32'h00000000;
    load_insn_o     = 1'b0;
    case (opcode_i)
        `INST_OR32_LBS: 
        begin
            case (mem_offset_i)
                2'b00 :   load_result_o[7:0] = mem_result_i[31:24];
                2'b01 :   load_result_o[7:0] = mem_result_i[23:16];
                2'b10 :   load_result_o[7:0] = mem_result_i[15:8];
                2'b11 :   load_result_o[7:0] = mem_result_i[7:0];
                default : ; 
            endcase
            if (load_result_o[7] == 1'b1)
                load_result_o[31:8] = 24'hFFFFFF;
            load_insn_o = 1'b1;
        end
        `INST_OR32_LBZ: 
        begin
            case (mem_offset_i)
                2'b00 :   load_result_o[7:0] = mem_result_i[31:24];
                2'b01 :   load_result_o[7:0] = mem_result_i[23:16];
                2'b10 :   load_result_o[7:0] = mem_result_i[15:8];
                2'b11 :   load_result_o[7:0] = mem_result_i[7:0];
                default : ; 
            endcase
            load_insn_o = 1'b1;
        end
        `INST_OR32_LHS: 
        begin
            case (mem_offset_i)
                2'b00 :   load_result_o[15:0] = mem_result_i[31:16];
                2'b10 :   load_result_o[15:0] = mem_result_i[15:0];
                default : ; 
            endcase
            if (load_result_o[15] == 1'b1)
                load_result_o[31:16] = 16'hFFFF;
            load_insn_o = 1'b1;
        end
        `INST_OR32_LHZ: 
        begin
            case (mem_offset_i)
                2'b00 :   load_result_o[15:0] = mem_result_i[31:16];
                2'b10 :   load_result_o[15:0] = mem_result_i[15:0];
                default : ; 
            endcase
            load_insn_o = 1'b1;
        end
        `INST_OR32_LWZ, `INST_OR32_LWS: 
        begin
            load_result_o   = mem_result_i;
            load_insn_o  = 1'b1;
        end
        default :
            ; 
    endcase
end
endmodule