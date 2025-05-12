
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
  assign regDst0 = r_format & ~x_found;
  assign regDst1 = jal & ~x_found;
  assign aluSrc = ((andi | ori) & ~x_found) | (~x_found & ((~x_found & addi) | ((lw | ~x_found) & (sw | lw))));
  assign memToReg0 = lw & ~x_found;
  assign memToReg1 = jal & ~x_found;
  assign regWrite = ~x_found & (addi | (((r_format | (ori | (andi | jal))) | lw) & ((((lw | ori) | r_format) | andi) | ~x_found)));
  assign memRead = lw & ~x_found;
  assign memWrite = ~x_found & sw;
  assign branch = beq & ~x_found;
  assign branch_ne = bne & ~x_found;
  assign jump = ((jal & ~x_found) | j) & ~x_found;
  assign alu_op[0] = (((bne & ~x_found) | (~x_found & (andi & ((r_format | ~x_found) & (r_format | andi))))) | ((((beq | ~x_found) & (bne | beq)) | (andi & ((r_format | ~x_found) & (r_format | andi)))) & (~x_found | ((beq | ~x_found) & (bne | beq))))) & ~x_found;
  assign alu_op[1] = ~x_found & (r_format | andi);
  assign alu_op[2] = ~x_found & ori;
endmodule

