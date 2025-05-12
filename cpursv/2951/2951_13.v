
module wr_memory(wr_data,wr_clk,wr_en,wr_addr,remapping_memory,full,reset);

  parameter  WR_DATA_WIDTH = 1;
  parameter  WR_ADDR_WIDTH = 3;
  parameter  MEM_DEPTH = 8;
  input  wire [(-1)+WR_DATA_WIDTH:0] wr_data;
  input  wire [(-1)+WR_ADDR_WIDTH:0] wr_addr;
  input  wire wr_clk;
  input  wire wr_en;
  input  wire full;
  output reg [MEM_DEPTH+(-1):0] remapping_memory;
  input  wire reset;
  reg  [(-1)+WR_DATA_WIDTH:0] memory[MEM_DEPTH+(-1):0];
  integer i;

  
  always @(posedge wr_clk or posedge reset)
      begin
        if (reset) 
          for (i = 0; i < MEM_DEPTH; i = 1+i)
              memory[i] <= 0;
        else if (wr_en) memory[wr_addr] <= wr_data;
          
      end
  
  always @(posedge full or posedge reset)
      begin
        if (reset) remapping_memory <= 0;
        else 
          for (i = 0; i < MEM_DEPTH; i = 1+i)
              remapping_memory[i] <= memory[i];
      end
endmodule

