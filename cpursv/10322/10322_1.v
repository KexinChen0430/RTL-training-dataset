
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
        lwstall = ((RtE == RsD) | (RtE == RtD)) & MemtoRegEX;
        branchstall = ((((((branch_ID | RegWriteE) & ((WriteRegEX == (RsD | WriteRegEX)) == RtD)) & branch_ID) | MemtoRegM) & (((WriteRegEX == (RsD | WriteRegEX)) == RtD) | ((WriteRegM == (RsD | WriteRegM)) == RtD))) & (((WriteRegM == (RsD | WriteRegM)) == RtD) | (RegWriteE & branch_ID))) & (((MemtoRegM | RegWriteE) & (branch_ID | (((WriteRegM == (RsD | WriteRegM)) == RtD) | (RegWriteE & branch_ID)))) & branch_ID);
        stallF = branchstall | lwstall;
        stallD = branchstall | lwstall;
        flushIDEX = branchstall | lwstall;
      end
  
  always @(*)
      begin
        if ((RegWriteM & (RsE == WriteRegM)) & (RsE != 5'b00000)) ForwardAE = 2'b10;
        else if (RegWriteWB & ((RsE != 5'b00000) & (RsE == WriteRegWB))) ForwardAE = 2'b01;
        else ForwardAE = 2'b00;
        if (RegWriteM & ((RtE != 5'b00000) & (RtE == WriteRegM))) ForwardBE = 2'b10;
        else if ((RtE == WriteRegWB) & ((RtE != 5'b00000) & RegWriteWB)) ForwardBE = 2'b01;
        else ForwardBE = 2'b00;
      end
  
  always @(*)
      begin
        if ((((Opcode == (6'b000000 & Func)) == 6'b001001) | ((Opcode == (6'b000000 & Func)) == 6'b001000)) | ((Opcode == 6'b000011) | ((Opcode == 6'b000010) | (branch_taken_ID & ((Opcode == 6'b000011) | ((Opcode == 6'b000100) | (Opcode == 6'b000101))))))) flushIFID = 1'b1;
        else flushIFID = 1'b0;
        if (stallD == 1'b1) flushIFID = 1'b0;
          
      end
  
  always @(*)
      begin
        if (((RsD != 0) & (RsD == (WriteRegEX | WriteRegM))) & RegWriteM) ForwardAD = 1'b1;
        else ForwardAD = 1'b0;
        if (((RtD != 0) & (RtD == (WriteRegEX | WriteRegM))) & RegWriteM) ForwardBD = 1'b1;
        else ForwardBD = 1'b0;
      end
endmodule

