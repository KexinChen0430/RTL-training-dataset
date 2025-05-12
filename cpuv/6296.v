module  omsp_clock_module (
    aclk_en,                      
    mclk,                         
    per_dout,                     
    por,                          
    puc,                          
    smclk_en,                     
    dbg_reset,                    
    dco_clk,                      
    lfxt_clk,                     
    oscoff,                       
    per_addr,                     
    per_din,                      
    per_en,                       
    per_wen,                      
    reset_n,                      
    scg1,                         
    wdt_reset                     
);
output              aclk_en;      
output              mclk;         
output       [15:0] per_dout;     
output              por;          
output              puc;          
output              smclk_en;     
input               dbg_reset;    
input               dco_clk;      
input               lfxt_clk;     
input               oscoff;       
input         [7:0] per_addr;     
input        [15:0] per_din;      
input               per_en;       
input         [1:0] per_wen;      
input               reset_n;      
input               scg1;         
input               wdt_reset;    
parameter           BCSCTL1    = 9'h057;
parameter           BCSCTL2    = 9'h058;
parameter           BCSCTL1_D  = (256'h1 << (BCSCTL1 /2));
parameter           BCSCTL2_D  = (256'h1 << (BCSCTL2 /2));
reg  [255:0]  reg_dec;
always @(per_addr)
  case (per_addr)
    (BCSCTL1 /2):     reg_dec  =  BCSCTL1_D;
    (BCSCTL2 /2):     reg_dec  =  BCSCTL2_D;
    default     :     reg_dec  =  {256{1'b0}};
  endcase
wire         reg_lo_write =  per_wen[0] & per_en;
wire         reg_hi_write =  per_wen[1] & per_en;
wire         reg_read     = ~|per_wen   & per_en;
wire [255:0] reg_hi_wr    = reg_dec & {256{reg_hi_write}};
wire [255:0] reg_lo_wr    = reg_dec & {256{reg_lo_write}};
wire [255:0] reg_rd       = reg_dec & {256{reg_read}};
reg  [7:0] bcsctl1;
wire       bcsctl1_wr  = BCSCTL1[0] ? reg_hi_wr[BCSCTL1/2] : reg_lo_wr[BCSCTL1/2];
wire [7:0] bcsctl1_nxt = BCSCTL1[0] ? per_din[15:8]        : per_din[7:0];
always @ (posedge mclk or posedge puc)
  if (puc)              bcsctl1  <=  8'h00;
  else if (bcsctl1_wr)  bcsctl1  <=  bcsctl1_nxt & 8'h30; 
reg  [7:0] bcsctl2;
wire       bcsctl2_wr  = BCSCTL2[0] ? reg_hi_wr[BCSCTL2/2] : reg_lo_wr[BCSCTL2/2];
wire [7:0] bcsctl2_nxt = BCSCTL2[0] ? per_din[15:8]        : per_din[7:0];
always @ (posedge mclk or posedge puc)
  if (puc)              bcsctl2  <=  8'h00;
  else if (bcsctl2_wr)  bcsctl2  <=  bcsctl2_nxt & 8'h0e; 
wire [15:0] bcsctl1_rd   = (bcsctl1  & {8{reg_rd[BCSCTL1/2]}})  << (8 & {4{BCSCTL1[0]}});
wire [15:0] bcsctl2_rd   = (bcsctl2  & {8{reg_rd[BCSCTL2/2]}})  << (8 & {4{BCSCTL2[0]}});
wire [15:0] per_dout =  bcsctl1_rd   |
                        bcsctl2_rd;
reg  [2:0] lfxt_clk_s;
always @ (posedge mclk or posedge puc)
  if (puc) lfxt_clk_s <=  3'b000;
  else     lfxt_clk_s <=  {lfxt_clk_s[1:0], lfxt_clk};
wire lfxt_clk_en = (lfxt_clk_s[1] & ~lfxt_clk_s[2]) & ~(oscoff & ~bcsctl2[`SELS]);
wire  mclk   =  dco_clk;
wire  mclk_n = !dco_clk;
reg [2:0] aclk_div;
wire      aclk_en = lfxt_clk_en & ((bcsctl1[`DIVAx]==2'b00) ?  1'b1          :
                                   (bcsctl1[`DIVAx]==2'b01) ?  aclk_div[0]   :
                                   (bcsctl1[`DIVAx]==2'b10) ? &aclk_div[1:0] :
                                                              &aclk_div[2:0]);
always @ (posedge mclk or posedge puc)
  if (puc)                                         aclk_div <=  3'h0;
  else if ((bcsctl1[`DIVAx]!=2'b00) & lfxt_clk_en) aclk_div <=  aclk_div+3'h1;
reg [2:0] smclk_div;
wire      smclk_in = ~scg1 & (bcsctl2[`SELS] ? lfxt_clk_en : 1'b1);
wire      smclk_en = smclk_in & ((bcsctl2[`DIVSx]==2'b00) ?  1'b1           :
                                 (bcsctl2[`DIVSx]==2'b01) ?  smclk_div[0]   :
                                 (bcsctl2[`DIVSx]==2'b10) ? &smclk_div[1:0] :
                                                            &smclk_div[2:0]);
always @ (posedge mclk or posedge puc)
  if (puc)                                      smclk_div <=  3'h0;
  else if ((bcsctl2[`DIVSx]!=2'b00) & smclk_in) smclk_div <=  smclk_div+3'h1;
wire      por_reset  =  !reset_n;
reg [1:0] por_s;
always @(posedge mclk_n or posedge por_reset)
  if (por_reset) por_s  <=  2'b11;
  else           por_s  <=  {por_s[0], 1'b0};
wire   por = por_s[1];
wire      puc_reset  = por_reset | wdt_reset | dbg_reset;
reg [1:0] puc_s;
always @(posedge mclk_n or posedge puc_reset)
  if (puc_reset) puc_s  <=  2'b11;
  else           puc_s  <=  {puc_s[0], 1'b0};
wire   puc = puc_s[1];
endmodule