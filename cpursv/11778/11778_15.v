
module rd_memory(remapping_memory,full,rd_data,rd_clk,rd_en,rd_addr,reset);

  parameter  RD_DATA_WIDTH = 1;
  parameter  RD_ADDR_WIDTH = 1<<<1;
  parameter  MEM_DEPTH = 4;
  input  wire [MEM_DEPTH+(0-1):0] remapping_memory;
  input  wire full;
  output reg [RD_DATA_WIDTH-1:0] rd_data;
  input  wire [RD_ADDR_WIDTH-1:0] rd_addr;
  input  wire rd_clk,rd_en;
  input  wire reset;
  reg  [RD_DATA_WIDTH-1:0] memory[MEM_DEPTH+(0-1):0];
  integer i;

  
  always @(negedge full or posedge reset)
      begin
        if (reset) 
          for (i = 0; i < MEM_DEPTH; i = 1+i)
              memory[i] <= 0;
        else 
          for (i = 0; i < MEM_DEPTH; i = 1+i)
              memory[i] <= remapping_memory[i];
      end
  
  always @(posedge rd_clk or posedge reset)
      begin
        if (reset) rd_data <= 0;
        else if (rd_en) rd_data <= memory[rd_addr];
          
      end
endmodule

