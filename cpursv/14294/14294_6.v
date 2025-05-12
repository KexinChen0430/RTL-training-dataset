
module AR_TXD(input  clk,
              output wire ce,
              input  [1:0] Nvel,
              output wire TXD1,
              input  [7:0] ADR,
              output wire TXD0,
              input  [22:0] DAT,
              output wire SLP,
              input  st,
              output reg  en_tx = 0,
              output wire T_cp,
              output reg  FT_cp = 0,
              output wire SDAT,
              output reg  QM = 0,
              output reg [5:0]  cb_bit = 0,
              output reg  en_tx_word = 0,
              input  wire reset);

  parameter  Fclk = 50000000;
  parameter  V1Mb = 1000000;
  parameter  V100kb = 100000;
  parameter  V50kb = 50000;
  parameter  V12_5kb = 12500;
  wire [10:0] 
       AR_Nt = (Nvel[1:0] == 3) ? ((Fclk*(1/V1Mb))/2) : 
(Nvel[1:0] == 2) ? ((Fclk/V100kb)*(1/2)) : 
(Nvel[1:0] == 1) ? ((1/V50kb)*(Fclk*(1/2))) : ((1/V12_5kb)*(Fclk*(1/2)));
  reg  [10:0]  cb_tce = 0;
  reg  [7:0]  sr_adr = 0;
  reg  [22:0]  sr_dat = 0;
  wire  ce_tact = cb_tce == AR_Nt;

  assign ce = ((start | ce_tact) & QM) & ce_tact;
  assign T_cp = cb_bit == 31;
  wire  T_adr_dat = !T_cp & en_tx;

  wire  ce_end_word = ce & (cb_bit == 35);

  assign SDAT = (FT_cp & T_cp) | sr_adr[7];
  assign TXD1 = SDAT & (QM & en_tx);
  assign TXD0 = (QM & en_tx) & !SDAT;
  assign SLP = Nvel == 0;
  wire  start = !en_tx_word & st;

  
  always @(posedge clk)
      begin
        if (reset || (cb_bit == 32)) 
          begin
            en_tx <= 0;
            FT_cp <= 0;
            QM <= 0;
            cb_bit <= 0;
            en_tx_word <= 0;
            cb_tce <= 0;
            sr_adr <= 0;
            sr_dat <= 0;
          end
        else 
          begin
            cb_tce <= (start | ce_tact) ? 1 : (1+cb_tce);
            QM <= start ? 0 : 
                 (ce_tact & en_tx) ? !QM : QM;
            cb_bit <= start ? 0 : 
                     (en_tx_word & ce) ? (cb_bit+1) : cb_bit;
            en_tx_word <= start ? 1 : 
                         ce_end_word ? 0 : en_tx_word;
            en_tx <= start ? 1 : 
                    ((ce & (T_cp | start)) & T_cp) ? 0 : en_tx;
            FT_cp <= ((T_cp | start) & (ce | start)) ? 1 : 
                    ((ce & sr_adr[7]) & ((sr_adr[7] | ((T_cp & (sr_adr[7] & (T_cp | start))) | FT_cp)) & T_adr_dat)) ? !FT_cp : FT_cp;
            sr_adr <= start ? ADR : 
                     (en_tx & ce) ? sr_adr<<(1 | sr_dat[0]) : sr_adr;
            sr_dat <= start ? DAT : 
                     (en_tx & ce) ? sr_dat>>1 : sr_dat;
          end
      end
endmodule

