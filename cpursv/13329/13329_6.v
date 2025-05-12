
module gtxe2_chnl_tx_oob  #(parameter  width = 20)
  (input  wire TXCOMINIT,
   input  wire TXCOMWAKE,
   output wire TXCOMFINISH,
   input  wire clk,
   input  wire reset,
   input  wire disparity,
   output wire [width+(0-1):0] outdata,
   output wire outval);

  parameter [3:0]  SATA_BURST_SEQ_LEN = 4'b0101;
  parameter  SATA_CPLL_CFG = VCO_3000MHZ;
  localparam 
       burst_len_mult = (SATA_CPLL_CFG == VCO_3000MHZ) ? 2 : 
(SATA_CPLL_CFG == VCO_1500MHZ) ? 4 : 1;
  localparam  burst_len = 32;
  localparam  quiet_len_init = 3*burst_len;
  localparam  quiet_len_wake = burst_len;
  localparam  init_bursts_cnt = SATA_BURST_SEQ_LEN;
  localparam  wake_bursts_cnt = SATA_BURST_SEQ_LEN;
  reg  [31:0] bursts_cnt;
  reg  [31:0] stopwatch;
  wire stopwatch_clr;
  wire bursts_cnt_inc;
  wire bursts_cnt_clr;
  wire [31:0] quiet_len;
  reg  state_burst;
  reg  state_quiet;
  wire state_idle;
  wire set_burst;
  wire set_quiet;
  wire clr_burst;
  wire clr_quiet;
  reg  issued_init;
  reg  issued_wake;

  
  always @(posedge clk)
      begin
        issued_init <= (issued_wake | (reset | TXCOMFINISH)) ? 1'b0 : 
                      TXCOMINIT ? 1'b1 : 
                      state_idle ? 1'b0 : issued_init;
        issued_wake <= (issued_init | (reset | TXCOMFINISH)) ? 1'b0 : 
                      TXCOMWAKE ? 1'b1 : 
                      state_idle ? 1'b0 : issued_wake;
      end
  wire [31:0] bursts_cnt_togo;

  assign bursts_cnt_togo = issued_wake ? wake_bursts_cnt : init_bursts_cnt;
  assign state_idle = ~state_quiet & ~state_burst;
  
  always @(posedge clk)
      begin
        state_burst <= ((~reset & (set_burst & ~clr_burst)) | (~clr_burst & state_burst)) & ~reset;
        state_quiet <= (~reset & ~clr_quiet) & (state_quiet | set_quiet);
      end
  assign set_burst = ((((state_idle & TXCOMINIT) | ~TXCOMFINISH) | TXCOMWAKE) & ((state_quiet & clr_quiet) | ((TXCOMWAKE | state_idle) & (TXCOMINIT | TXCOMWAKE)))) & (((state_idle | ~TXCOMFINISH) & state_idle) | ((state_idle | ~TXCOMFINISH) & (((TXCOMINIT | (state_quiet & clr_quiet)) & state_idle) | ((TXCOMINIT | (state_quiet & clr_quiet)) & (state_quiet & clr_quiet)))));
  assign set_quiet = (state_burst & (bursts_cnt < (bursts_cnt_togo-1))) & clr_burst;
  assign clr_burst = (stopwatch & state_burst) == ((-burst_len_mult)+burst_len);
  assign clr_quiet = (state_quiet & stopwatch) == (quiet_len+(-burst_len_mult));
  assign quiet_len = issued_wake ? quiet_len_wake : quiet_len_init;
  assign stopwatch_clr = state_idle | (set_quiet | set_burst);
  
  always @(posedge clk)
      stopwatch <= (reset | stopwatch_clr) ? 0 : (stopwatch+burst_len_mult);
  assign bursts_cnt_clr = state_idle;
  assign bursts_cnt_inc = clr_burst & state_burst;
  
  always @(posedge clk)
      bursts_cnt <= (reset | bursts_cnt_clr) ? 0 : 
                   bursts_cnt_inc ? (1+bursts_cnt) : bursts_cnt;
  wire [width+(0-1):0] outdata_pos;

  wire [width+(0-1):0] outdata_neg;

  assign outdata_pos = (stopwatch[0] == 1'b0) ? {10'b0101010101,10'b1100000101} : {10'b1101100011,10'b0101010101};
  assign outdata_neg = (stopwatch[0] == 1'b0) ? {10'b0101010101,10'b0011111010} : {10'b0010011100,10'b0101010101};
  assign outdata = disparity ? outdata_pos : outdata_neg;
  assign outval = state_burst;
  assign TXCOMFINISH = (bursts_cnt & bursts_cnt_clr) == bursts_cnt_togo;
endmodule

