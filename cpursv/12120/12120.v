
module Control_Unit(RegDst,ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,Jump,
                    SignExtend,ALUOp,Opcode);

  input  [5:0] Opcode;
  output RegDst;
  output ALUSrc;
  output MemToReg;
  output RegWrite;
  output MemRead;
  output MemWrite;
  output Branch;
  output Jump;
  output SignExtend;
  output [3:0] ALUOp;
  reg  
      RegDst    ,
      ALUSrc    ,
      MemToReg  ,
      RegWrite  ,
      MemRead   ,
      MemWrite  ,
      Branch    ,
      Jump      ,
      SignExtend;
  reg  [3:0] ALUOp;

  
  always @(Opcode)
      begin
        case (Opcode)

          6'b000000: begin
                RegDst <= 1;
                ALUSrc <= 0;
                MemToReg <= 0;
                RegWrite <= 1;
                MemRead <= 0;
                MemWrite <= 0;
                Branch <= 0;
                Jump <= 0;
                SignExtend <= 1'bX;
                ALUOp <= 4'b1111;
              end

        endcase

      end
endmodule

