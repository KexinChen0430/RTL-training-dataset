
module Control(input  irq,PC31,
               input  [5:0] OpCode,Funct,
               output [2:0] PCSrc,
               output [1:0] RegDst,MemtoReg,nextPC,
               output 
      RegWrite,
      ALUSrc1 ,
      ALUSrc2 ,
      Branch  ,
      MemWrite,
      MemRead ,
      ExtOp   ,
      LuOp    ,
      Sign    ,
               output reg [5:0] ALUFun);

  wire EXC;
  reg  [5:0] f;
  parameter  ALUadd = 6'b000_000;
  parameter  ALUsub = 6'b000_001;
  parameter  ALUand = 6'b011_000;
  parameter  ALUor = 6'b011_110;
  parameter  ALUxor = 6'b010_110;
  parameter  ALUnor = 6'b010_001;
  parameter  ALUnop = 6'b011_010;
  parameter  ALUsll = 6'b100_000;
  parameter  ALUsrl = 6'b100_001;
  parameter  ALUsra = 6'b100_011;
  parameter  ALUeq = 6'b110_011;
  parameter  ALUneq = 6'b110_001;
  parameter  ALUlt = 6'b110_101;
  parameter  ALUlez = 6'b111_101;
  parameter  ALUgez = 6'b111_001;
  parameter  ALUgtz = 6'b111_111;

  assign EXC = ~(
(
((OpCode >= 6'h1) || 
((OpCode == 6'h23) || (OpCode == 6'hf)) || ((OpCode == 6'h2b) || (OpCode == 6'h0))) && 
((OpCode == 6'h2b) || (OpCode == 6'h0) || 
((OpCode == 6'h23) || (OpCode == 6'hf) || (OpCode <= 6'hd))) && 
(((Funct <= 6'h27) && (Funct == 6'h2)) || 
((Funct <= 6'h27) && 
((Funct == 6'h3) || (Funct == 6'h0) || 
((Funct == 6'h9) || (Funct == 6'h8)) || (Funct >= 6'h20))))) || 
(
(
(
((Funct == 6'h3) || 
((Funct == 6'h9) || 
((Funct == 6'h2) || 
((Funct == 6'h0) || (Funct == 6'h8))) || (Funct <= 6'h27))) && 
((Funct == 6'h3) || (Funct == 6'h0) || (Funct == 6'h2))) || 
(
((Funct == 6'h3) || 
((Funct == 6'h9) || 
((Funct == 6'h2) || 
((Funct == 6'h0) || (Funct == 6'h8))) || (Funct <= 6'h27))) && ((Funct == 6'h9) || (Funct == 6'h8)))) && 
(
((OpCode >= 6'h1) || 
((OpCode == 6'h23) || (OpCode == 6'hf)) || ((OpCode == 6'h2b) || (OpCode == 6'h0))) && 
((OpCode == 6'h2b) || (OpCode == 6'h0) || 
((OpCode == 6'h23) || (OpCode == 6'hf) || (OpCode <= 6'hd))))) || 
(
((OpCode >= 6'h1) || 
((OpCode == 6'h23) || (OpCode == 6'hf)) || ((OpCode == 6'h2b) || (OpCode == 6'h0))) && 
((OpCode == 6'h2b) || (OpCode == 6'h0) || 
((OpCode == 6'h23) || (OpCode == 6'hf) || (OpCode <= 6'hd))) && 
((Funct == 6'h2b) || (Funct == 6'h2a) || 
(
(((OpCode >= 6'h1) || (OpCode == 6'h23)) && 
((OpCode == 6'h23) || (OpCode <= 6'hd))) || (OpCode == 6'hf) || (OpCode == 6'h2b)))));
  assign PCSrc = (irq & ~PC31) ? 3'h4 : 
                 (~PC31 & EXC) ? 3'h5 : 
                 (OpCode == 6'h00) ? (((Funct == 6'h09) | (Funct == 6'h08)) ? 3'h3 : 3'h0) : 
                 ((OpCode == 6'h03) || (OpCode == 6'h02)) ? 3'h2 : 
                 ((OpCode == 6'h01) || 
                 (((OpCode == 6'h01) && (OpCode < 6'h08)) || 
((OpCode < 6'h08) && (OpCode > 6'h03)))) ? 3'h1 : 3'h0;
  assign nextPC = (OpCode == 6'h00) ? (((Funct == 6'h09) | (Funct == 6'h08)) ? 2'h3 : 2'h0) : 
                  ((OpCode == 6'h03) || (OpCode == 6'h02)) ? 2'h2 : 
                  ((OpCode == 6'h01) || 
                  (((OpCode == 6'h01) && (OpCode < 6'h08)) || 
((OpCode < 6'h08) && (OpCode > 6'h03)))) ? 2'h1 : 2'h0;
  assign Branch = (OpCode < 6'h08) ? 1'b1 : 1'b0;
  assign RegWrite = ((irq & ~PC31) | (~PC31 & EXC)) ? 1'b1 : 
                    ((OpCode == 6'h2b) || 
                    ((OpCode == 6'h06) || (OpCode == 6'h07) || 
((OpCode == 6'h04) || (OpCode == 6'h01) || 
(OpCode == 6'h02)) || (OpCode == 6'h05)) || ((OpCode == 6'h00) && (Funct == 6'h08))) ? 1'b0 : 1'b1;
  assign RegDst = ((irq & ~PC31) | (~PC31 & EXC)) ? 2'h3 : 
                  ((OpCode == 6'ha) || (OpCode == 6'hb) || (OpCode == 6'hd) || 
                  ((OpCode == 6'h23) || (OpCode == 6'hf) || 
((OpCode == 6'hc) || (OpCode == 6'h9)) || (OpCode == 6'h8))) ? 2'h1 : 
                  (((OpCode == 6'h0) || (OpCode == 6'h03)) && 
                  ((OpCode == 6'h03) || (Funct == 6'h9))) ? 2'h2 : 2'h0;
  assign MemRead = ((irq & ~PC31) | (OpCode == 6'h23)) ? 1'b1 : 1'b0;
  assign MemWrite = (OpCode == 6'h2b) ? 1'b1 : 1'b0;
  assign MemtoReg = ((irq & ~PC31) | (~PC31 & EXC)) ? 2'h2 : 
                    (OpCode == 6'h23) ? 2'h1 : 
                    (
((OpCode == 6'h03) || 
((OpCode == 6'h00) && (Funct == 6'h08)) || (OpCode == 6'h00)) && 
                    ((OpCode == 6'h03) || 
((OpCode == 6'h00) && (Funct == 6'h08)) || (Funct == 6'h09))) ? 2'h2 : 2'h0;
  assign ALUSrc1 = (OpCode == 6'h00) ? (((Funct == 6'h3) || (Funct == 6'h0) || (Funct == 6'h2)) ? 1'b1 : 1'b0) : 1'b0;
  assign ALUSrc2 = ((OpCode == 6'h00) || 
                   ((OpCode <= 6'h7) && (OpCode >= 6'h1))) ? 1'b0 : 1'b1;
  assign ExtOp = (OpCode == 6'h0) ? (((Funct == 6'h8) || (Funct == 6'h2a) || 
((Funct == 6'h22) || (Funct == 6'h20))) ? 1'b1 : 1'b0) : 
                 (
(
((OpCode == 6'h1) || (OpCode == 6'ha) || (OpCode >= 6'h4)) && 
((OpCode == 6'h1) || 
((OpCode == 6'h2b) || (OpCode == 6'h23) || (OpCode == 6'h8)) || ((OpCode <= 6'h7) || (OpCode == 6'ha)))) || 
                 ((OpCode == 6'h2b) || (OpCode == 6'h23) || (OpCode == 6'h8))) ? 1'b1 : 1'b0;
  assign LuOp = (OpCode == 6'h0f) ? 1'b1 : 1'b0;
  assign Sign = ExtOp;
  
  always @(*)
      case (Funct)

        6'd32: f = ALUadd;

        6'd33: f = ALUadd;

        6'd34: f = ALUsub;

        6'd35: f = ALUsub;

        6'd36: f = ALUand;

        6'd37: f = ALUor;

        6'd38: f = ALUxor;

        6'd39: f = ALUnor;

        6'd0: f = ALUsll;

        6'd2: f = ALUsrl;

        6'd3: f = ALUsra;

        6'd42: f = ALUlt;

        6'd43: f = ALUlt;

        6'd8: f = ALUadd;

        6'd9: f = ALUadd;

        default: f = ALUnop;

      endcase

  
  always @(*)
      case (OpCode)

        6'h00: ALUFun = f;

        6'h23: ALUFun = ALUadd;

        6'h2b: ALUFun = ALUadd;

        6'h0f: ALUFun = ALUadd;

        6'h08: ALUFun = ALUadd;

        6'h09: ALUFun = ALUadd;

        6'h0c: ALUFun = ALUand;

        6'h0d: ALUFun = ALUor;

        6'h0a: ALUFun = ALUlt;

        6'h0b: ALUFun = ALUlt;

        6'h04: ALUFun = ALUeq;

        6'h05: ALUFun = ALUneq;

        6'h06: ALUFun = ALUlez;

        6'h07: ALUFun = ALUgtz;

        6'h01: ALUFun = ALUgez;

        6'h02: ALUFun = ALUadd;

        6'h03: ALUFun = ALUadd;

        default: ALUFun = ALUnop;

      endcase

endmodule

