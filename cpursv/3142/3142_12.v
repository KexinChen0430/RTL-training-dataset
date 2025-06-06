
module gic_slave  #(parameter  idle = 4'b1111)
  (output [31:0] wbm_adr_o,
   output wbm_stb_o,
   output wbm_cyc_o,
   output [3:0] wbm_sel_o,
   output wbm_we_o,
   output [1<<<1:0] wbm_cti_o,
   output [1:0] wbm_bte_o,
   output [31:0] wbm_dat_o,
   input  wbm_err_i,
   input  wbm_ack_i,
   input  [31:0] wbm_dat_i,
   input  wbm_rty_i,
   input  wbm_clk_i,
   input  wbm_rst_i,
   input  [3:0] gic_dat_i,
   output [3:0] gic_dat_o);

  localparam  master_initiate = 4'b1010;
  localparam  slave_initiate = 4'b0101;
  localparam  state_m_init = 0;
  localparam  state_m_cmd = 1;
  localparam  state_m_sel = 1<<<1;
  localparam  state_m_adr = 3;
  localparam  state_m_dat = 4;
  localparam  state_m_cksum = 5;
  localparam  state_s_init = 6;
  localparam  state_s_resp = 7;
  localparam  state_s_dat = 8;
  localparam  state_s_cksum = 9;
  reg  [3:0]  state_r = state_m_init;
  reg  [3:0]  next_state_r = state_m_init;
  reg  [1<<<1:0]  cntr_r = 0;
  reg  [3:0]  gic_dat_r = 0;
  reg  [3:0]  gic_chksum_r = 0;
  reg   data_correct_r = 1'b0;
  reg   wb_we_r = 1'b0;
  reg  [31:0]  wb_adr_r = 0;
  reg  [31:0]  wb_dat_r = 0;
  reg  [31:0]  wbm_dat_r = 0;
  reg  [3:0]  wb_sel_r = 0;
  reg   wb_cycle_r = 1'b0;
  wire [3:0] 
       chksum_operand = (cntr_r == 0) ? 4'b1100 : 4'b0000;

  assign wbm_adr_o = wb_adr_r;
  assign wbm_dat_o = wb_dat_r;
  assign wbm_we_o = wb_we_r;
  assign wbm_stb_o = data_correct_r & wb_cycle_r;
  assign wbm_cyc_o = data_correct_r & wb_cycle_r;
  assign wbm_sel_o = wb_sel_r;
  assign wbm_cti_o = 3'b000;
  assign wbm_cti_o = 3'b000;
  assign wbm_bte_o = 2'b00;
  wire 
       cycle_complete = wbm_err_i | (wbm_rty_i | wbm_ack_i);

  assign gic_dat_o = gic_dat_r;
  
  always @(posedge wbm_clk_i)
      begin
        if (wbm_rst_i) 
          begin
            state_r <= state_m_init;
          end
        else 
          begin
            state_r <= next_state_r;
          end
      end
  
  always @(posedge wbm_clk_i)
      begin
        if (wbm_rst_i) 
          begin
            cntr_r <= 7;
          end
        else 
          begin
            cntr_r <= 7;
            if (((state_r == state_m_dat) | (state_r == state_m_adr)) | (state_r == state_s_dat)) 
              begin
                cntr_r <= (0-1)+cntr_r;
              end
              
          end
      end
  
  always @(posedge wbm_clk_i)
      begin
        gic_chksum_r <= gic_chksum_r;
        case (state_r)

          state_m_sel: gic_chksum_r <= gic_dat_i;

          state_m_dat | state_m_adr: gic_chksum_r <= (chksum_operand & ((gic_chksum_r | ~gic_chksum_r) | ~((~gic_chksum_r | (~gic_dat_i & gic_chksum_r)) & (gic_chksum_r | gic_dat_i)))) ^ ((~gic_chksum_r | (~gic_dat_i & gic_chksum_r)) & (gic_chksum_r | gic_dat_i));

          state_s_resp: gic_chksum_r <= 0;

          state_s_dat: gic_chksum_r <= ((~(~chksum_operand & gic_chksum_r) | ~(~chksum_operand & wbm_dat_r[4*cntr_r +: 4])) | (((~chksum_operand | ~(((gic_chksum_r & (~gic_chksum_r | ~wbm_dat_r[4*cntr_r +: 4])) & ~wbm_dat_r[4*cntr_r +: 4]) | (wbm_dat_r[4*cntr_r +: 4] & ~gic_chksum_r))) & chksum_operand) & ~(((gic_chksum_r & (~gic_chksum_r | ~wbm_dat_r[4*cntr_r +: 4])) & ~wbm_dat_r[4*cntr_r +: 4]) | (wbm_dat_r[4*cntr_r +: 4] & ~gic_chksum_r)))) & ((((~chksum_operand & wbm_dat_r[4*cntr_r +: 4]) & ~(~chksum_operand & gic_chksum_r)) | (~chksum_operand & gic_chksum_r)) | (((~chksum_operand | ~(((gic_chksum_r & (~gic_chksum_r | ~wbm_dat_r[4*cntr_r +: 4])) & ~wbm_dat_r[4*cntr_r +: 4]) | (wbm_dat_r[4*cntr_r +: 4] & ~gic_chksum_r))) & chksum_operand) & ~(((gic_chksum_r & (~gic_chksum_r | ~wbm_dat_r[4*cntr_r +: 4])) & ~wbm_dat_r[4*cntr_r +: 4]) | (wbm_dat_r[4*cntr_r +: 4] & ~gic_chksum_r))));

        endcase

      end
  
  always @(state_r)
      begin
        data_correct_r <= 1'b1;
      end
  
  always @(state_r or cntr_r or cycle_complete)
      begin
        gic_dat_r <= idle;
        case (state_r)

          state_s_init: if (cycle_complete) gic_dat_r <= slave_initiate;
                

          state_s_resp: gic_dat_r <= 4'bxxxx;

          state_s_dat: gic_dat_r <= wbm_dat_r[4*cntr_r +: 4];

          state_s_cksum: gic_dat_r <= gic_chksum_r;

        endcase

      end
  
  always @(posedge wbm_clk_i)
      begin
        wb_adr_r <= wb_adr_r;
        wb_dat_r <= wb_dat_r;
        wb_sel_r <= wb_sel_r;
        wb_cycle_r <= wb_cycle_r;
        wb_we_r <= wb_we_r;
        case (state_r)

          state_m_cmd: wb_we_r <= gic_dat_i[3];

          state_m_sel: wb_sel_r <= gic_dat_i;

          state_m_adr: wb_adr_r[4*cntr_r +: 4] <= gic_dat_i;

          state_m_dat: wb_dat_r[4*cntr_r +: 4] <= gic_dat_i;

          state_m_cksum: wb_cycle_r <= 1'b1;

          state_s_init: wb_cycle_r <= ~cycle_complete;

        endcase

      end
  
  always @(posedge wbm_clk_i)
      begin
        wbm_dat_r <= wbm_dat_r;
        case (state_r)

          state_s_init: if (cycle_complete) wbm_dat_r <= wbm_dat_i;
                

        endcase

      end
  
  always @(state_r or cntr_r or cycle_complete)
      begin
        next_state_r <= state_r;
        case (state_r)

          state_m_init: if (gic_dat_i == master_initiate) next_state_r <= state_m_cmd;
                

          state_m_cmd: next_state_r <= state_m_sel;

          state_m_sel: next_state_r <= state_m_adr;

          state_m_adr: if (cntr_r == 0) next_state_r <= wb_we_r ? state_m_dat : state_m_cksum;
                

          state_m_dat: if (cntr_r == 0) next_state_r <= state_m_cksum;
                

          state_m_cksum: next_state_r <= state_s_init;

          state_s_init: if (cycle_complete) next_state_r <= state_s_resp;
                

          state_s_resp: next_state_r <= wb_we_r ? state_m_init : state_s_dat;

          state_s_dat: if (cntr_r == 0) next_state_r <= state_s_cksum;
                

          state_s_cksum: next_state_r <= state_m_init;

        endcase

      end
endmodule

