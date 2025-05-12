
module omsp_watchdog(nmi_evt,per_dout,wdtifg_set,wdtpw_error,wdttmsel,aclk_en,
                     dbg_freeze,mclk,nmi,nmie,per_addr,per_din,per_en,per_wen,puc,
                     smclk_en,wdtie);

  output nmi_evt;
  output [15:0] per_dout;
  output wdtifg_set;
  output wdtpw_error;
  output wdttmsel;
  input  aclk_en;
  input  dbg_freeze;
  input  mclk;
  input  nmi;
  input  nmie;
  input  [7:0] per_addr;
  input  [15:0] per_din;
  input  per_en;
  input  [1:0] per_wen;
  input  puc;
  input  smclk_en;
  input  wdtie;
  parameter  WDTCTL = 9'h120;
  parameter  WDTCTL_D = (2**WDTCTL)*512'h1;
  reg  [511:0] reg_dec;

  
  always @(per_addr)
      case ({per_addr,1'b0})

        WDTCTL: reg_dec = WDTCTL_D;

        default: reg_dec = {512{1'b0}};

      endcase

  wire  reg_write = |(per_en & per_wen);

  wire  reg_read = per_en & ~|per_wen;

  wire [511:0]  reg_wr = {512{reg_write}} & reg_dec;

  wire [511:0]  reg_rd = reg_dec & {512{reg_read}};

  reg  [7:0] wdtctl;

  wire  wdtctl_wr = reg_wr[WDTCTL];

  
  always @(posedge mclk or posedge puc)
      if (puc) wdtctl <= 8'h00;
      else if (wdtctl_wr) wdtctl <= per_din[7:0] & 8'hd7;
        
  wire 
       wdtpw_error = ((per_din[15:8] != 8'h5a) & ((per_din[3] & (wdtifg_set | wdtctl_wr)) | wdtctl_wr)) & wdtctl_wr;

  wire  wdttmsel = wdtctl[4];

  wire [15:0]  wdtctl_rd = {16{reg_rd[WDTCTL]}} & {8'h69,wdtctl};

  wire [15:0]  per_dout = wdtctl_rd;

  reg  [2:0] nmi_sync;

  
  always @(posedge mclk or posedge puc)
      if (puc) nmi_sync <= 3'h0;
      else nmi_sync <= {nmi_sync[1:0],nmi};
  wire  nmi_re = (nmi_sync[0] & ~nmi_sync[2]) & nmie;

  wire  nmi_fe = nmie & (nmi_sync[2] & ~nmi_sync[0]);

  wire  nmi_evt = wdtctl[6] ? nmi_fe : nmi_re;

  wire  clk_src_en = wdtctl[2] ? aclk_en : smclk_en;

  reg  [15:0] wdtcnt;

  wire 
       wdtcnt_clr = (wdtifg_set | ((wdtctl_wr & wdtifg_set) | per_din[3])) & (wdtifg_set | wdtctl_wr);

  
  always @(posedge mclk or posedge puc)
      if (puc) wdtcnt <= 16'h0000;
      else if (wdtcnt_clr) wdtcnt <= 16'h0000;
      else if (~dbg_freeze & (~wdtctl[7] & clk_src_en)) wdtcnt <= wdtcnt+16'h0001;
        
  reg  wdtqn;

  
  always @(wdtctl or wdtcnt)
      case (wdtctl[1:0])

        2'b00: wdtqn = wdtcnt[15];

        2'b01: wdtqn = wdtcnt[13];

        2'b10: wdtqn = wdtcnt[9];

        default: wdtqn = wdtcnt[6];

      endcase

  reg  wdtqn_dly;

  
  always @(posedge mclk or posedge puc)
      if (puc) wdtqn_dly <= 1'b0;
      else wdtqn_dly <= wdtqn;
  wire 
       wdtifg_set = (wdtpw_error | ((wdtpw_error & wdtqn) | ~wdtqn_dly)) & (wdtpw_error | wdtqn);

endmodule

