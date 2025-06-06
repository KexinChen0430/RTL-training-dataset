
module ControlUnit(input  [5:0] Special,
                   output reg RegDst,
                   output reg Branch,
                   output reg MemRead,
                   output reg MemtoReg,
                   output reg [1:0] AluOp,
                   output reg MemWrite,
                   output reg ALUSrc,
                   output reg RegWrite);

  
  always @* 
      begin
        case (Special)

          'b100000: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 1;
                MemtoReg <= 1;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                AluOp <= 2'b00;
              end

          'b100001: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 1;
                MemtoReg <= 1;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                AluOp <= 2'b00;
              end

          'b100011: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 1;
                MemtoReg <= 1;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                AluOp <= 2'b00;
              end

          'b100111: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 1;
                MemtoReg <= 1;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                AluOp <= 2'b00;
              end

          'b100100: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 1;
                MemtoReg <= 1;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                AluOp <= 2'b00;
              end

          'b100101: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 1;
                MemtoReg <= 1;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                AluOp <= 2'b00;
              end

          'b101000: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 1;
                ALUSrc <= 1;
                RegWrite <= 0;
                AluOp <= 2'b00;
              end

          'b101001: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 1;
                ALUSrc <= 1;
                RegWrite <= 0;
                AluOp <= 2'b00;
              end

          'b101011: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 1;
                ALUSrc <= 1;
                RegWrite <= 0;
                AluOp <= 2'b00;
              end

          'b001000: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                AluOp <= 2'b11;
              end

          'b001100: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                AluOp <= 2'b11;
              end

          'b001101: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                AluOp <= 2'b11;
              end

          'b001110: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                AluOp <= 2'b11;
              end

          'b001010: begin
                RegDst <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                AluOp <= 2'b11;
              end

          'b000100: begin
                RegDst <= 0;
                Branch <= 1;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 0;
                AluOp <= 2'b01;
              end

          'b000101: begin
                RegDst <= 0;
                Branch <= 1;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 0;
                AluOp <= 2'b01;
              end

          default: begin
                RegDst <= 1;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 1;
                AluOp <= 2'b10;
              end

        endcase

         ;
      end
endmodule

