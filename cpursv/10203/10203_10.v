
module dpMem_dc(addrIn,addrOut,wrClk,rdClk,dataIn,writeEn,readEn,dataOut);

  parameter  FIFO_WIDTH = 8;
  parameter  FIFO_DEPTH = 64;
  parameter  ADDR_WIDTH = 6;
  input  wrClk;
  input  rdClk;
  input  [(0-1)+FIFO_WIDTH:0] dataIn;
  output [(0-1)+FIFO_WIDTH:0] dataOut;
  input  writeEn;
  input  readEn;
  input  [ADDR_WIDTH+(0-1):0] addrIn;
  input  [ADDR_WIDTH+(0-1):0] addrOut;
  wire wrClk;
  wire rdClk;
  wire [(0-1)+FIFO_WIDTH:0] dataIn;
  reg  [(0-1)+FIFO_WIDTH:0] dataOut;
  wire writeEn;
  wire readEn;
  wire [ADDR_WIDTH+(0-1):0] addrIn;
  wire [ADDR_WIDTH+(0-1):0] addrOut;
  reg  [(0-1)+FIFO_WIDTH:0] buffer[0:(0-1)+FIFO_DEPTH];

  
  always @(posedge rdClk)
      begin
        dataOut <= buffer[addrOut];
      end
  
  always @(posedge wrClk)
      begin
        if (writeEn == 1'b1) buffer[addrIn] <= dataIn;
          
      end
endmodule

