
module ControlUnit(clk,OPCODE,BOpCode,Zero,BSelector,MemRD,MemWD,RegWrite,
                   RegSelector,PCSelect,Enable1,Enable2,Enable3,Enable4);

  input  wire clk;
  input  [4:0] OPCODE;
  input  Zero;
  input  [4:0] BOpCode;
  output reg BSelector;
  output reg MemRD;
  output reg MemWD;
  output reg RegWrite;
  output reg [1:0] RegSelector;
  output reg PCSelect;
  output reg Enable1;
  output reg Enable2;
  output reg Enable3;
  output reg Enable4;
  parameter  ADD = 5'd0;
  parameter  SUB = 5'd1;
  parameter  ADDI = 5'd2;
  parameter  SUBI = 5'd3;
  parameter  MLT = 5'd4;
  parameter  MLTI = 5'd5;
  parameter  AND = 5'd6;
  parameter  OR = 5'd7;
  parameter  ANDI = 5'd8;
  parameter  ORI = 5'd9;
  parameter  SLR = 5'd10;
  parameter  SLL = 5'd11;
  parameter  LDR = 5'd12;
  parameter  STR = 5'd13;
  parameter  BNE = 5'd14;
  parameter  BEQ = 5'd15;
  parameter  J = 5'd16;
  parameter  CMP = 5'd17;
  parameter  NOP = 5'b11111;

  
  initial  
  begin
    BSelector = 1'd0;
    PCSelect = 1'd0;
    MemRD = 1'd0;
    MemWD = 1'd0;
    RegWrite = 1'd0;
    RegSelector = 2'd0;
    Enable1 = 1'd1;
    Enable2 = 1'd1;
    Enable3 = 1'd1;
    Enable4 = 1'd1;
  end
  
  always @(posedge clk)
      begin
        case (OPCODE)

          ADD: begin
                BSelector = 1'd0;
                MemRD = 1'd0;
                MemWD = 1'd0;
                RegWrite = 1'd1;
                RegSelector = 2'd0;
              end

        endcase

      end
  
  always @(Zero or BOpCode)
      begin
        if (!Zero && (BOpCode == BNE)) PCSelect = 1'd1;
        else if ((BOpCode == BEQ) && Zero) PCSelect = 1'd1;
        else PCSelect = 1'd0;
      end
endmodule

