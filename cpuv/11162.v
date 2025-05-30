module ALU (
    input rst, 
    input[`RegDataWidth-1:0] srcA, 
    input[`RegDataWidth-1:0] srcB, 
    input[`ALUTypeWidth-1:0] AluType, 
    input[`ALUOpWidth-1:0] AluOp, 
    input[`RegDataWidth-1:0] hi_in, 
    input[`RegDataWidth-1:0] lo_in, 
    output reg is_Overflow, 
    output reg[`RegDataWidth-1:0] data_out, 
    output reg we_hi, 
    output reg we_lo, 
    output reg[`RegDataWidth-1:0] hi_out, 
    output reg[`RegDataWidth-1:0] lo_out 
);
    wire[2 * `RegDataWidth-1:0] positive_srcA;
    wire[2 * `RegDataWidth-1:0] positive_srcB;
    wire[2 * `RegDataWidth-1:0] positive_mult_temp;
    wire[2 * `RegDataWidth-1:0] multu_temp;
    wire[`RegDataWidth-1:0] positive_div_temp;
    wire[`RegDataWidth-1:0] positive_quo_temp;
    wire[2 * `RegDataWidth-1:0] divu_temp;
    assign positive_srcA = (srcA[`RegDataWidth-1] == 1'b1) ? (~srcA + 1) : srcA;
    assign positive_srcB = (srcB[`RegDataWidth-1] == 1'b1) ? (~srcB + 1) : srcB;
    assign positive_mult_temp = positive_srcA * positive_srcB;
    assign multu_temp = (srcA[`RegDataWidth-1] ^ srcB[`RegDataWidth-1]) ? (~positive_mult_temp + 1) : positive_mult_temp;
    assign positive_div_temp = positive_srcA / positive_srcB;
    assign positive_quo_temp = positive_srcA % positive_srcB;
    always @(*) begin : proc_alu
        if(rst == ~`RstEnable) begin 
            case (AluType) 
                `ALU_ADD_SUB: begin 
                    we_hi <= ~`WriteEnable; 
                    we_lo <= ~`WriteEnable; 
                    case (AluOp) 
                        `Addu: begin 
                            data_out <= srcA + srcB; 
                            is_Overflow <= ~`Overflow; 
                        end
                        `Add: begin 
                            data_out <= srcA + srcB; 
                            if ((data_out[`RegDataWidth-1] ^ srcA[`RegDataWidth-1]) &&
                                (srcA[`RegDataWidth-1] ~^ srcB[`RegDataWidth-1]))
                                is_Overflow <= `Overflow; 
                            else is_Overflow <= ~`Overflow; 
                        end
                        `Subu: begin 
                            data_out <= srcA - srcB; 
                            is_Overflow <= ~`Overflow; 
                        end
                        `Sub: begin 
                            data_out <= srcA - srcB; 
                            if ((data_out[`RegDataWidth-1] ^ srcA[`RegDataWidth-1]) &&
                                (srcA[`RegDataWidth-1] ^ srcB[`RegDataWidth-1]))
                                is_Overflow <= `Overflow; 
                            else is_Overflow <= ~`Overflow; 
                        end
                        default: begin 
                        end
                    endcase
                end
                `ALU_MUL_DIV: begin 
                    is_Overflow <= ~`Overflow; 
                    we_hi <= `WriteEnable; 
                    we_lo <= `WriteEnable; 
                    case (AluOp) 
                        `Mult: begin 
                            if (srcA[`RegDataWidth-1] ^ srcB[`RegDataWidth-1]) begin
                                hi_out <= multu_temp[2 * `RegDataWidth-1:`RegDataWidth]; 
                                lo_out <= multu_temp[`RegDataWidth-1:0]; 
                            end
                            else begin
                                hi_out <= positive_mult_temp[2 * `RegDataWidth-1:`RegDataWidth]; 
                                lo_out <= positive_mult_temp[`RegDataWidth-1:0]; 
                            end
                        end
                        `Multu: begin 
                            hi_out <= multu_temp[2 * `RegDataWidth-1:`RegDataWidth]; 
                            lo_out <= multu_temp[`RegDataWidth-1:0]; 
                        end
                        `Div: begin 
                            if (srcA[`RegDataWidth-1] ^ srcB[`RegDataWidth-1]) begin
                                lo_out <= ~positive_div_temp + 1; 
                            end
                            else begin
                                lo_out <= positive_div_temp; 
                            end
                            if (srcA[`RegDataWidth-1] == 1'b0)
                                hi_out <= positive_quo_temp; 
                            else
                                hi_out <= ~positive_quo_temp + 1; 
                        end
                        `Divu: begin 
                            lo_out <= srcA / srcB; 
                            hi_out <= srcA % srcB; 
                        end
                        default: begin 
                        end
                    endcase
                end
                `ALU_LOGIC: begin 
                    is_Overflow <= ~`Overflow; 
                    we_hi <= ~`WriteEnable; 
                    we_lo <= ~`WriteEnable; 
                    case (AluOp) 
                        `And: data_out <= srcA & srcB; 
                        `Or: data_out <= srcA | srcB; 
                        `Xor: data_out <= srcA ^ srcB; 
                        `Nor: data_out <= ~(srcA | srcB); 
                        default: begin 
                        end
                    endcase
                end
                `ALU_SHIFT: begin 
                    is_Overflow <= ~`Overflow; 
                    we_hi <= ~`WriteEnable; 
                    we_lo <= ~`WriteEnable; 
                    case (AluOp) 
                        `Sll: data_out <= srcB << srcA[4:0]; 
                        `Srl: data_out <= srcB >> srcA[4:0]; 
                        `Sra: data_out <= ( {`RegDataWidth{srcB[`RegDataWidth-1]}} << (6'd32 - {1'b0, srcA[4:0]}) )
                        | (srcB >> srcA[4:0]); 
                        default: begin 
                        end
                    endcase
                end
                `ALU_COMP: begin 
                    is_Overflow <= ~`Overflow; 
                    we_hi <= ~`WriteEnable; 
                    we_lo <= ~`WriteEnable; 
                    case (AluOp) 
                        `Slt : begin 
                            if (srcA[`RegDataWidth-1] ^ srcB[`RegDataWidth-1]) begin
                                data_out <= (srcA[`RegDataWidth-1] == 1'b1) ? 1 : 0;
                            end
                            else data_out <= (srcA < srcB) ? 1 : 0;
                        end
                        `Sltu: begin 
                            data_out <= (srcA < srcB) ? 1 : 0;
                        end
                        default : begin 
                        end
                    endcase
                end
                `ALU_OTHER: begin 
                    is_Overflow <= ~`Overflow; 
                    we_hi <= ~`WriteEnable; 
                    we_lo <= ~`WriteEnable; 
                    case (AluOp) 
                        `Mfhi: data_out <= hi_in; 
                        `Mflo: data_out <= lo_in; 
                        `Lui : data_out <= srcB << 16; 
                        default: begin 
                        end
                    endcase
                end
                default: begin 
                end
            endcase
        end
        else data_out <= `ZeroWord; 
    end
endmodule