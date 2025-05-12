
module control(input  [5:0] op,
               output [2:0] alu_op,
               output 
      regDst0  ,
      regDst1  ,
      aluSrc   ,
      memToReg0,
      memToReg1,
      regWrite ,
               output memRead,memWrite,branch,branch_ne,jump);

  reg  
      addi    ,
      andi    ,
      lw      ,
      sw      ,
      ori     ,
      beq     ,
      bne     ,
      j       ,
      jal     ,
      slti    ,
      r_format,
      x_found ;

  
  always @(*)
      begin
        addi <= 1'b0;
        lw <= 1'b0;
        sw <= 1'b0;
        ori <= 1'b0;
        beq <= 1'b0;
        bne <= 1'b0;
        j <= 1'b0;
        jal <= 1'b0;
        andi <= 1'b0;
        ori <= 1'b0;
        r_format <= 1'b0;
        x_found <= 1'b0;
        case (op)

          6'dx: x_found <= 1'b1;

          6'b001000: addi <= 1'b1;

          6'b100011: lw <= 1'b1;

          6'b101011: sw <= 1'b1;

          6'b000100: beq <= 1'b1;

          6'b000101: bne <= 1'b1;

          6'b000010: j <= 1'b1;

          6'b000011: jal <= 1'b1;

          6'b001010: slti <= 1'b1;

          6'b000000: r_format <= 1'b1;

          6'b001100: andi <= 1'b1;

          6'b001101: ori <= 1'b1;

          6'b001000: andi <= 1'b1;

        endcase

      end
  assign regDst0 = ~x_found & r_format;
  assign regDst1 = ~x_found & jal;
  assign aluSrc = (~x_found & sw) | (~x_found & (((ori | andi) | lw) | addi));
  assign memToReg0 = lw & ~x_found;
  assign memToReg1 = ~x_found & jal;
  assign regWrite = (((jal | (r_format | lw)) & ~x_found) | (~x_found & (andi | (ori & ~x_found)))) | (~x_found & addi);
  assign memRead = lw & ~x_found;
  assign memWrite = ~x_found & sw;
  assign branch = ~x_found & beq;
  assign branch_ne = bne & ~x_found;
  assign jump = (j | jal) & ~x_found;
  assign alu_op[0] = ((~x_found & andi) | ((beq | bne) & (beq | ~x_found))) & ~x_found;
  assign alu_op[1] = (r_format | andi) & ~x_found;
  assign alu_op[2] = ori & ~x_found;
endmodule

