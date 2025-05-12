module src_a_mux(
                 input wire [`SRC_A_SEL_WIDTH-1:0] src_a_sel,
                 input wire [`ADDR_LEN-1:0] 	   pc,
                 input wire [`DATA_LEN-1:0] 	   rs1,
                 output reg [`DATA_LEN-1:0] 	   alu_src_a
                 );
   always @(*) begin
      case (src_a_sel)
        `SRC_A_RS1 : alu_src_a = rs1;
        `SRC_A_PC : alu_src_a = pc;
        default : alu_src_a = 0;
      endcase 
   end
endmodule