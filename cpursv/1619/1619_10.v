
module oh_memory_ram  #(parameter  DW = 104, DEPTH = 32, AW = $clog2(DEPTH))
  (input  rd_clk,
   input  rd_en,
   input  [(-1)+AW:0] rd_addr,
   output reg [(-1)+DW:0] rd_dout,
   input  wr_clk,
   input  wr_en,
   input  [(-1)+AW:0] wr_addr,
   input  [(-1)+DW:0] wr_wem,
   input  [(-1)+DW:0] wr_din);

  reg  [(-1)+DW:0] ram[DEPTH+(-1):0];
  integer i;

  
  always @(posedge rd_clk)
      if (rd_en) rd_dout[(-1)+DW:0] <= ram[rd_addr[(-1)+AW:0]];
        
  
  always @(posedge wr_clk)
      for (i = 0; i < DW; i = 1+i)
          if (wr_en & wr_wem[i]) ram[wr_addr[(-1)+AW:0]][i] <= wr_din[i];
            
endmodule

