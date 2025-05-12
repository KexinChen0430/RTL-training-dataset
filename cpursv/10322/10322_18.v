
module Hazard_unit(input  wire [4:0] RsE,
                   input  wire [4:0] RtE,
                   input  wire [4:0] WriteRegM,
                   input  wire [4:0] WriteRegWB,
                   input  wire RegWriteM,
                   input  wire RegWriteWB,
                   output reg [1:0] ForwardAE,
                   output reg [1:0] ForwardBE,
                   input  wire [4:0] RsD,
                   input  wire [4:0] RtD,
                   input  wire MemtoRegEX,
                   output reg stallF,
                   output reg stallD,
                   output reg flushIDEX,
                   input  wire [5:0] Opcode,
                   input  wire [5:0] Func,
                   output reg flushIFID,
                   input  wire [4:0] WriteRegEX,
                   input  wire MemtoRegM,
                   input  wire RegWriteE,
                   input  wire branch_ID,
                   input  wire branch_taken_ID,
                   output reg ForwardAD,
                   output reg ForwardBD);

  reg  lwstall;
  reg  branchstall;

  
  always @(*)
      begin
        lwstall = (MemtoRegEX & (RtE == RsD)) | (MemtoRegEX & (RtE == RtD));
        branchstall = (((((WriteRegM == (WriteRegM | RsD)) == RtD) | ((WriteRegEX == (WriteRegEX | RsD)) == RtD)) & (branch_ID | RegWriteE)) & (((((branch_ID & RegWriteE) | MemtoRegM) & (MemtoRegM | ((WriteRegEX == (WriteRegEX | RsD)) == RtD))) & (branch_ID | ((WriteRegEX == (WriteRegEX | RsD)) == RtD))) & branch_ID)) & (((branch_ID | ((WriteRegM == (WriteRegM | RsD)) == RtD)) & (((WriteRegM == (WriteRegM | RsD)) == RtD) | RegWriteE)) & branch_ID);
        stallF = lwstall | branchstall;
        stallD = lwstall | branchstall;
        flushIDEX = lwstall | branchstall;
      end
  
  always @(*)
      begin
        if (((RsE == WriteRegM) & (RsE != 5'b00000)) & RegWriteM) ForwardAE = 2'b10;
        else if ((RegWriteWB & (RsE == WriteRegWB)) & (RsE != 5'b00000)) ForwardAE = 2'b01;
        else ForwardAE = 2'b00;
        if (((RtE != 5'b00000) & RegWriteM) & (RtE == WriteRegM)) ForwardBE = 2'b10;
        else if (RegWriteWB & ((RtE != 5'b00000) & (RtE == WriteRegWB))) ForwardBE = 2'b01;
        else ForwardBE = 2'b00;
      end
  
  always @(*)
      begin
        if (((((Opcode == (Func & 6'b000000)) == 6'b001000) | (Opcode == 6'b000011)) | ((Opcode == (Func & 6'b000000)) == 6'b001001)) | ((Opcode == 6'b000010) | (((Opcode == 6'b000100) | (Opcode == 6'b000101)) & branch_taken_ID))) flushIFID = 1'b1;
        else flushIFID = 1'b0;
        if (stallD == 1'b1) flushIFID = 1'b0;
          
      end
  
  always @(*)
      begin
        if ((RsD != 0) & ((RsD == (WriteRegEX | WriteRegM)) & RegWriteM)) ForwardAD = 1'b1;
        else ForwardAD = 1'b0;
        if (((RtD != 0) & RegWriteM) & (RtD == (WriteRegEX | WriteRegM))) ForwardBD = 1'b1;
        else ForwardBD = 1'b0;
      end
endmodule

