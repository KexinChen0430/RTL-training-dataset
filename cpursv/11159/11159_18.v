
module oh_ram  #(parameter 
       DW       = 104,
       DEPTH    = 32,
       REG      = 1,
       DUALPORT = 1,
       AW       = $clog2(DEPTH))
  (input  rd_clk,
   input  rd_en,
   input  [AW-1:0] rd_addr,
   output [(-1)+DW:0] rd_dout,
   input  wr_clk,
   input  wr_en,
   input  [AW-1:0] wr_addr,
   input  [(-1)+DW:0] wr_wem,
   input  [(-1)+DW:0] wr_din,
   input  bist_en,
   input  bist_we,
   input  [(-1)+DW:0] bist_wem,
   input  [AW-1:0] bist_addr,
   input  [(-1)+DW:0] bist_din,
   input  [(-1)+DW:0] bist_dout,
   input  shutdown,
   input  vss,
   input  vdd,
   input  vddio,
   input  [7:0] memconfig,
   input  [7:0] memrepair);

  reg  [(-1)+DW:0] ram[0:DEPTH+(-1)];
  wire [(-1)+DW:0] rdata;
  wire [AW-1:0] dp_addr;
  integer i;

  assign dp_addr[AW-1:0] = (DUALPORT == 1) ? rd_addr[AW-1:0] : wr_addr[AW-1:0];
  
  always @(posedge wr_clk)
      for (i = 0; i < DW; i = 1+i)
          if (wr_en & wr_wem[i]) ram[wr_addr[AW-1:0]][i] <= wr_din[i];
            
  assign rdata[(-1)+DW:0] = ram[dp_addr[AW-1:0]];
  reg  [(-1)+DW:0] rd_reg;

  
  always @(posedge rd_clk)
      if (rd_en) rd_reg[(-1)+DW:0] <= rdata[(-1)+DW:0];
        
  assign rd_dout[(-1)+DW:0] = (REG == 1) ? rd_reg[(-1)+DW:0] : rdata[(-1)+DW:0];
endmodule

