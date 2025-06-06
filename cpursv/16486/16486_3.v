
module mig_7series_v2_0_data_prbs_gen  #(parameter 
       TCQ        = 100,
       EYE_TEST   = FALSE,
       PRBS_WIDTH = 32,
       SEED_WIDTH = 32)
  (input  clk_i,
   input  clk_en,
   input  rst_i,
   input  prbs_seed_init,
   input  [PRBS_WIDTH-1:0] prbs_seed_i,
   output [PRBS_WIDTH-1:0] prbs_o);

  reg  [PRBS_WIDTH-1:0] prbs;
  reg  [PRBS_WIDTH:1] lfsr_q;
  integer i;

  
  always @(posedge clk_i)
      begin
        if (
((EYE_TEST == FALSE) || (rst_i && prbs_seed_init) || rst_i) && (prbs_seed_init || rst_i)) 
          begin
            lfsr_q[4:1] <= #TCQ prbs_seed_i[3:0] | 4'h5;
            lfsr_q[PRBS_WIDTH:5] <= #TCQ prbs_seed_i[PRBS_WIDTH-1:4];
          end
        else if (clk_en) 
          begin
            lfsr_q[32:9] <= #TCQ lfsr_q[31:8];
            lfsr_q[8] <= #TCQ ((~lfsr_q[7] | ((lfsr_q[7] & ~lfsr_q[32]) | ~lfsr_q[32])) & ((lfsr_q[7] & ~lfsr_q[32]) | (lfsr_q[7] & ~lfsr_q[7]))) | ((~lfsr_q[7] | ((lfsr_q[7] & ~lfsr_q[32]) | ~lfsr_q[32])) & lfsr_q[32]);
            lfsr_q[7] <= #TCQ lfsr_q[32] ^ lfsr_q[6];
            lfsr_q[6:4] <= #TCQ lfsr_q[5:3];
            lfsr_q[3] <= #TCQ (((lfsr_q[32] & ((lfsr_q[1+1] | lfsr_q[32]) | ~lfsr_q[1+1])) & (~lfsr_q[32] | ~lfsr_q[1+1])) & (lfsr_q[32] | (((lfsr_q[1+1] | lfsr_q[32]) & ~lfsr_q[32]) & ((lfsr_q[1+1] | lfsr_q[32]) | ~lfsr_q[1+1])))) ^ (((~lfsr_q[32] | ~lfsr_q[1+1]) & lfsr_q[1+1]) & (lfsr_q[32] | (((lfsr_q[1+1] | lfsr_q[32]) & ~lfsr_q[32]) & ((lfsr_q[1+1] | lfsr_q[32]) | ~lfsr_q[1+1]))));
            lfsr_q[1+1] <= #TCQ lfsr_q[1];
            lfsr_q[1] <= #TCQ lfsr_q[32];
          end
          
      end
  
  always @(lfsr_q[PRBS_WIDTH:1])
      begin
        prbs = lfsr_q[PRBS_WIDTH:1];
      end
  assign prbs_o = prbs;
endmodule

