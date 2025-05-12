module here (add other control signals below)
  assign CISEL = (OP == 3'b001) ? 1'b1 : 1'b0;
  assign BSEL = (OP == 3'b001) ? 1'b1 : 1'b0;
  always @(*) begin
    case (OP)
      ADD: begin
        OSEL = 2'b0;
        SHIFT_LA = 1'b0;
        SHIFT_LR = 1'b0;
        LOGICAL_OP = 1'b0;
      end
      SUB: begin
        OSEL = 2'b0;
        SHIFT_LA = 1'b0;
        SHIFT_LR = 1'b0;
        LOGICAL_OP = 1'b0;
      end
      SRA: begin
        OSEL = 2'b01;
        SHIFT_LA = 1'b1;
        SHIFT_LR = 1'b1;
        LOGICAL_OP = 1'b0;
      end
      SRL: begin
        OSEL = 2'b01;
        SHIFT_LA = 1'b0;
        SHIFT_LR = 1'b1;
        LOGICAL_OP = 1'b0;
      end
      SLL: begin
        OSEL = 2'b01;
        SHIFT_LA = 1'b1;
        SHIFT_LR = 1'b0;
        LOGICAL_OP = 1'b0;
      end
      AND: begin
        OSEL = 2'b10;
        SHIFT_LA = 1'b0;
        SHIFT_LR = 1'b0;
        LOGICAL_OP = 1'b1;
      end
      OR:  begin
        OSEL = 2'b10;
        SHIFT_LA = 1'b0;
        SHIFT_LR = 1'b0;
        LOGICAL_OP = 1'b0;
      end
      default: begin
        OSEL = 2'b11;
        SHIFT_LA = 1'b0;
        SHIFT_LR = 1'b0;
        LOGICAL_OP = 1'b0;
      end
    endcase
  end
endmodule