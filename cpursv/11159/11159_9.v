
module oh_ram  #(parameter 
       DW       = 104,
       DEPTH    = 32,
       REG      = 1,
       DUALPORT = 1,
       AW       = $clog2(DEPTH))
  (input  rd_clk,
   input  rd_en,
   input  [(0-1)+AW:0] rd_addr,
   output [DW+(0-1):0] rd_dout,
   input  wr_clk,
   input  wr_en,
   input  [(0-1)+AW:0] wr_addr,
   input  [DW+(0-1):0] wr_wem,
   input  [DW+(0-1):0] wr_din,
   input  bist_en,
   input  bist_we,
   input  [DW+(0-1):0] bist_wem,
   input  [(0-1)+AW:0] bist_addr,
   input  [DW+(0-1):0] bist_din,
   input  [DW+(0-1):0] bist_dout,
   input  shutdown,
   input  vss,
   input  vdd,
   input  vddio,
   input  [7:0] memconfig,
   input  [7:0] memrepair);

  reg  [DW+(0-1):0] ram[0:DEPTH+(0-1)];
  wire [DW+(0-1):0] rdata;
  wire [(0-1)+AW:0] dp_addr;
  integer i;

  assign dp_addr[(0-1)+AW:0] = (DUALPORT == 1) ? rd_addr[(0-1)+AW:0] : wr_addr[(0-1)+AW:0];
  
  always @(posedge wr_clk)
      for (i = 0; i < DW; i = i+1)
          if (wr_wem[i] & wr_en) ram[wr_addr[(0-1)+AW:0]][i] <= wr_din[i];
            
  assign rdata[DW+(0-1):0] = ram[dp_addr[(0-1)+AW:0]];
  reg  [DW+(0-1):0] rd_reg;

  
  always @(posedge rd_clk)
      if (rd_en) rd_reg[DW+(0-1):0] <= rdata[DW+(0-1):0];
        
  assign rd_dout[DW+(0-1):0] = (REG == 1) ? rd_reg[DW+(0-1):0] : rdata[DW+(0-1):0];
endmodule

