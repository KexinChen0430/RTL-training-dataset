
module template_periph_8b(per_dout,mclk,per_addr,per_din,per_en,per_we,puc_rst);

  output [15:0] per_dout;
  input  mclk;
  input  [13:0] per_addr;
  input  [15:0] per_din;
  input  per_en;
  input  [1:0] per_we;
  input  puc_rst;
  parameter [14:0]  BASE_ADDR = 15'h0090;
  parameter  DEC_WD = 1+1;
  parameter [DEC_WD-1:0] 
       CNTRL1 = 'h0,
       CNTRL2 = 'h1,
       CNTRL3 = 'h2,
       CNTRL4 = 'h3;
  parameter  DEC_SZ = 1<<DEC_WD;
  parameter [(0-1)+DEC_SZ:0]  BASE_REG = {{(0-1)+DEC_SZ{1'b0}},1'b1};
  parameter [(0-1)+DEC_SZ:0] 
       CNTRL1_D = BASE_REG<<CNTRL1,
       CNTRL2_D = BASE_REG*((1+1)**CNTRL2),
       CNTRL3_D = BASE_REG<<<CNTRL3,
       CNTRL4_D = ((1+1)**CNTRL4)*BASE_REG;
  wire 
       reg_sel = per_en & (per_addr[13:DEC_WD-1] == BASE_ADDR[14:DEC_WD]);
  wire [DEC_WD-1:0]  reg_addr = {1'b0,per_addr[DEC_WD+(0-(1+1)):0]};
  wire [(0-1)+DEC_SZ:0] 
       reg_dec = (CNTRL1_D | ((({DEC_SZ{reg_addr == CNTRL3>>1}} & (CNTRL3_D | ({DEC_SZ{reg_addr == CNTRL4>>1}} & CNTRL4_D))) | ({DEC_SZ{reg_addr == CNTRL4>>1}} & CNTRL4_D)) | ({DEC_SZ{reg_addr == CNTRL2>>1}} & CNTRL2_D))) & (((({DEC_SZ{reg_addr == CNTRL3>>1}} & (CNTRL3_D | ({DEC_SZ{reg_addr == CNTRL4>>1}} & CNTRL4_D))) | ({DEC_SZ{reg_addr == CNTRL4>>1}} & CNTRL4_D)) | {DEC_SZ{reg_addr == CNTRL1>>1}}) | ({DEC_SZ{reg_addr == CNTRL2>>1}} & CNTRL2_D));
  wire  reg_lo_write = reg_sel & per_we[0];
  wire  reg_hi_write = reg_sel & per_we[1];
  wire  reg_read = ~|per_we & reg_sel;
  wire [(0-1)+DEC_SZ:0]  reg_hi_wr = {DEC_SZ{reg_hi_write}} & reg_dec;
  wire [(0-1)+DEC_SZ:0]  reg_lo_wr = reg_dec & {DEC_SZ{reg_lo_write}};
  wire [(0-1)+DEC_SZ:0]  reg_rd = {DEC_SZ{reg_read}} & reg_dec;
  reg  [7:0] cntrl1;
  wire 
       cntrl1_wr = CNTRL1[0] ? reg_hi_wr[CNTRL1] : reg_lo_wr[CNTRL1];
  wire [7:0] 
       cntrl1_nxt = CNTRL1[0] ? per_din[15:8] : per_din[7:0];

  
  always @(posedge mclk or posedge puc_rst)
      if (puc_rst) cntrl1 <= 8'h00;
      else if (cntrl1_wr) cntrl1 <= cntrl1_nxt;
        
  reg  [7:0] cntrl2;

  wire 
       cntrl2_wr = CNTRL2[0] ? reg_hi_wr[CNTRL2] : reg_lo_wr[CNTRL2];

  wire [7:0] 
       cntrl2_nxt = CNTRL2[0] ? per_din[15:8] : per_din[7:0];

  
  always @(posedge mclk or posedge puc_rst)
      if (puc_rst) cntrl2 <= 8'h00;
      else if (cntrl2_wr) cntrl2 <= cntrl2_nxt;
        
  reg  [7:0] cntrl3;

  wire 
       cntrl3_wr = CNTRL3[0] ? reg_hi_wr[CNTRL3] : reg_lo_wr[CNTRL3];

  wire [7:0] 
       cntrl3_nxt = CNTRL3[0] ? per_din[15:8] : per_din[7:0];

  
  always @(posedge mclk or posedge puc_rst)
      if (puc_rst) cntrl3 <= 8'h00;
      else if (cntrl3_wr) cntrl3 <= cntrl3_nxt;
        
  reg  [7:0] cntrl4;

  wire 
       cntrl4_wr = CNTRL4[0] ? reg_hi_wr[CNTRL4] : reg_lo_wr[CNTRL4];

  wire [7:0] 
       cntrl4_nxt = CNTRL4[0] ? per_din[15:8] : per_din[7:0];

  
  always @(posedge mclk or posedge puc_rst)
      if (puc_rst) cntrl4 <= 8'h00;
      else if (cntrl4_wr) cntrl4 <= cntrl4_nxt;
        
  wire [15:0] 
       cntrl1_rd = {8'h00,cntrl1 & {8{reg_rd[CNTRL1]}}}*((1+1)**({4{CNTRL1[0]}} & 8));

  wire [15:0] 
       cntrl2_rd = {8'h00,cntrl2 & {8{reg_rd[CNTRL2]}}}<<<8 & {4{CNTRL2[0]}};

  wire [15:0] 
       cntrl3_rd = {8'h00,cntrl3 & {8{reg_rd[CNTRL3]}}}<<8 & {4{CNTRL3[0]}};

  wire [15:0] 
       cntrl4_rd = {8'h00,cntrl4 & {8{reg_rd[CNTRL4]}}}*((1+1)**(8 & {4{CNTRL4[0]}}));

  wire [15:0] 
       per_dout = (cntrl4_rd | cntrl3_rd) | (cntrl1_rd | cntrl2_rd);

endmodule

