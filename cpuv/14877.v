module control_single(opcode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jmp, ALUOp);
    input [5:0] opcode; 
    output RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jmp;
    output [1:0] ALUOp; 
    reg    RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jmp;
    reg    [1:0] ALUOp;
    parameter R_FORMAT = 6'd0;
    parameter LW = 6'd35;
    parameter SW = 6'd43;
    parameter BEQ = 6'd4;
    parameter ADDI = 6'd8;
    parameter BNE = 6'd5;
    parameter J = 6'd2;
    always @(opcode)
    begin
        case (opcode)
          R_FORMAT : 
          begin
              RegDst=1'b1; ALUSrc=1'b0; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; Branch=1'b0; Jmp=1'b0; ALUOp = 2'b10;
          end
          LW : 
          begin
              RegDst=1'b0; ALUSrc=1'b1; MemtoReg=1'b1; RegWrite=1'b1; MemRead=1'b1;
              MemWrite=1'b0; Branch=1'b0; Jmp=1'b0; ALUOp = 2'b00;
          end
          SW : 
          begin
              RegDst=1'bx; ALUSrc=1'b1; MemtoReg=1'bx; RegWrite=1'b0; MemRead=1'b0;
              MemWrite=1'b1; Branch=1'b0; Jmp=1'b0; ALUOp = 2'b00;
          end
          BEQ : 
          begin
              RegDst=1'bx; ALUSrc=1'b0; MemtoReg=1'bx; RegWrite=1'b0; MemRead=1'b0;
              MemWrite=1'b0; Branch=1'b1; Jmp=1'b0; ALUOp = 2'b01;
          end
           ADDI : 
           begin
               RegDst=1'b0; ALUSrc=1'b1; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
               MemWrite=1'bx; Branch=1'b0; Jmp=1'b0; ALUOp = 2'b00;
           end
            BNE : 
              begin
                  RegDst=1'bx; ALUSrc=1'b0; MemtoReg=1'bx; RegWrite=1'b0; MemRead=1'b0;
                  MemWrite=1'b0; Branch=1'b1; Jmp=1'b0; ALUOp = 2'b01;
              end
            J : 
            begin
                RegDst=1'bx; ALUSrc=1'bx; MemtoReg=1'bx; RegWrite=1'bx; MemRead=1'bx;
                MemWrite=1'b0; Branch=1'b0; Jmp=1'b1; ALUOp = 2'bxx;
            end
          default: 
          begin
              $display("control_single unimplemented opcode %d", opcode);
              RegDst=1'bx; ALUSrc=1'bx; MemtoReg=1'bx; RegWrite=1'bx; MemRead=1'bx;
              MemWrite=1'bx; Branch=1'bx; Jmp=1'b0; ALUOp = 2'bxx;
          end
        endcase
    end
endmodule