
module oh_memory_ram  #(parameter  DW = 104, DEPTH = 32, AW = $clog2(DEPTH))
  (input  rd_clk,
   input  rd_en,
   input  [AW+(-1):0] rd_addr,
   output reg [(-1)+DW:0] rd_dout,
   input  wr_clk,
   input  wr_en,
   input  [AW+(-1):0] wr_addr,
   input  [(-1)+DW:0] wr_wem,
   input  [(-1)+DW:0] wr_din);

  reg  [(-1)+DW:0] ram[DEPTH-1:0];
  integer i;

  
  always @(posedge rd_clk)
      if (rd_en) rd_dout[(-1)+DW:0] <= ram[rd_addr[AW+(-1):0]];
        
  
  always @(posedge wr_clk)
      for (i = 0; i < DW; i = i+1)
          if (wr_en & wr_wem[i]) ram[wr_addr[AW+(-1):0]][i] <= wr_din[i];
            
endmodule

