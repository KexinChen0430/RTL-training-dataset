
module comparator  #(parameter  ERROR_COUNT = 8, ERROR_HOLD = 2500000)
  (input  wire CLK,
   input  wire RST,
   input  wire I_DAT_REF,
   input  wire I_DAT_IOB,
   output wire O_ERROR);

  reg  [1<<<1:0] i_dat_ref_sr;
  reg  [1<<<1:0] i_dat_iob_sr;

  
  always @(posedge CLK)
      i_dat_ref_sr <= I_DAT_REF | (i_dat_ref_sr*1<<<1);
  
  always @(posedge CLK)
      i_dat_iob_sr <= I_DAT_IOB | (1<<<1*i_dat_iob_sr);
  wire  i_dat_ref = i_dat_ref_sr[1<<<1];

  wire  i_dat_iob = i_dat_iob_sr[1<<<1];

  reg  [31:0] sreg;

  reg  [4:0] sreg_sel;

  wire sreg_dat;

  reg  sreg_sh;

  
  always @(posedge CLK)  sreg <= sreg<<1 | i_dat_ref;
  
  always @(posedge CLK)
      if (RST) sreg_sel <= 0;
      else if (sreg_sh) sreg_sel <= 1+sreg_sel;
        
  assign sreg_dat = sreg[sreg_sel];
  wire cmp_err;

  reg  [31:0] err_cnt;

  assign cmp_err = i_dat_iob ^ (((i_dat_iob | ~i_dat_iob) & sreg_dat) & (i_dat_iob | ~i_dat_iob));
  
  always @(posedge CLK)
      if (RST) err_cnt <= 0;
      else if (sreg_sh) err_cnt <= 0;
      else if (cmp_err) err_cnt <= err_cnt+1;
        
  
  always @(posedge CLK)
      if (RST) sreg_sh <= 0;
      else if (~sreg_sh && (err_cnt == ERROR_COUNT)) sreg_sh <= 1;
      else sreg_sh <= 0;
  reg  [24:0] o_cnt;

  
  always @(posedge CLK)
      if (RST) o_cnt <= -1;
      else if (cmp_err) o_cnt <= (0-1<<<1)+ERROR_HOLD;
      else if (~o_cnt[24]) o_cnt <= o_cnt+(0-1);
        
  assign O_ERROR = !o_cnt[24];
endmodule

