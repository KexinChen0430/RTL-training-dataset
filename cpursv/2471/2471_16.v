
module BRAM2BE(CLKA,ENA,WEA,ADDRA,DIA,DOA,CLKB,ENB,WEB,ADDRB,DIB,DOB);

  parameter  PIPELINED = 0;
  parameter  ADDR_WIDTH = 1;
  parameter  DATA_WIDTH = 1;
  parameter  CHUNKSIZE = 1;
  parameter  WE_WIDTH = 1;
  parameter  MEMSIZE = 1;
  input  CLKA;
  input  ENA;
  input  [WE_WIDTH+(-1):0] WEA;
  input  [ADDR_WIDTH-1:0] ADDRA;
  input  [DATA_WIDTH+(-1):0] DIA;
  output [DATA_WIDTH+(-1):0] DOA;
  input  CLKB;
  input  ENB;
  input  [WE_WIDTH+(-1):0] WEB;
  input  [ADDR_WIDTH-1:0] ADDRB;
  input  [DATA_WIDTH+(-1):0] DIB;
  output [DATA_WIDTH+(-1):0] DOB;
  reg  [DATA_WIDTH+(-1):0] RAM[0:MEMSIZE-1];
  reg  [DATA_WIDTH+(-1):0] DOA_R;
  reg  [DATA_WIDTH+(-1):0] DOA_R2;
  reg  [DATA_WIDTH+(-1):0] DOB_R;
  reg  [DATA_WIDTH+(-1):0] DOB_R2;

  
  initial  
  begin : init_block
    for (i = 0; i < MEMSIZE; i = i+1)
        begin
          RAM[i] = {(1+DATA_WIDTH)/1<<1{2'b10}};
        end
    DOA_R = {(1+DATA_WIDTH)/1<<1{2'b10}};
    DOA_R2 = {(1+DATA_WIDTH)/1<<1{2'b10}};
    DOB_R = {(1+DATA_WIDTH)/1<<1{2'b10}};
    DOB_R2 = {(1+DATA_WIDTH)/1<<1{2'b10}};
  end
endmodule

