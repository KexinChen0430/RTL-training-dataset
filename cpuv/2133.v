module src_b_mux(
                 input wire [`SRC_B_SEL_WIDTH-1:0] src_b_sel,
                 input wire [`DATA_LEN-1:0] 	   imm,
                 input wire [`DATA_LEN-1:0] 	   rs2,
                 output reg [`DATA_LEN-1:0] 	   alu_src_b
                 );
   always @(*) begin
      case (src_b_sel)
        `SRC_B_RS2 : alu_src_b = rs2;
        `SRC_B_IMM : alu_src_b = imm;
        `SRC_B_FOUR : alu_src_b = 4;
        default : alu_src_b = 0;
      endcase 
   end
endmodule