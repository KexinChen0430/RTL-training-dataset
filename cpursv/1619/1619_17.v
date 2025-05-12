
module oh_memory_ram  #(parameter  DW = 104, DEPTH = 32, AW = $clog2(DEPTH))
  (input  rd_clk,
   input  rd_en,
   input  [AW+(0-1):0] rd_addr,
   output reg [DW+(0-1):0] rd_dout,
   input  wr_clk,
   input  wr_en,
   input  [AW+(0-1):0] wr_addr,
   input  [DW+(0-1):0] wr_wem,
   input  [DW+(0-1):0] wr_din);

  reg  [DW+(0-1):0] ram[DEPTH+(0-1):0];
  integer i;

  
  always @(posedge rd_clk)
      if (rd_en) rd_dout[DW+(0-1):0] <= ram[rd_addr[AW+(0-1):0]];
        
  
  always @(posedge wr_clk)
      for (i = 0; i < DW; i = 1+i)
          if (wr_wem[i] & wr_en) ram[wr_addr[AW+(0-1):0]][i] <= wr_din[i];
            
endmodule

