module sparc_exu_eclbyplog (
   rs_sel_mux1_m, rs_sel_mux1_w, rs_sel_mux1_w2, rs_sel_mux1_other,
   rs_sel_mux2_usemux1, rs_sel_mux2_rf, rs_sel_mux2_e,
   rs_sel_mux2_ld, rs_sel_longmux_g2, rs_sel_longmux_w2,
   rs_sel_longmux_ldxa,
   sehold, use_other, rs, rd_e, rd_m, ecl_irf_rd_w, ld_rd_g,
   wb_byplog_rd_w2, wb_byplog_rd_g2, tid_d, thr_match_de,
   thr_match_dm, ecl_irf_tid_w, ld_thr_match_dg, wb_byplog_tid_w2,
   ld_thr_match_dg2, ifu_exu_kill_e, wb_e, bypass_m,
   lsu_exu_dfill_vld_g, bypass_w, wb_byplog_wen_w2, wb_byplog_wen_g2,
   ecl_byp_ldxa_g
   ) ;
   input sehold;
   input use_other;
   input [4:0] rs;              
   input [4:0] rd_e;            
   input [4:0] rd_m;
   input [4:0] ecl_irf_rd_w;
   input [4:0] ld_rd_g;
   input [4:0] wb_byplog_rd_w2;
   input [4:0] wb_byplog_rd_g2;
   input [1:0] tid_d;
   input       thr_match_de;
   input       thr_match_dm;
   input [1:0] ecl_irf_tid_w;
   input       ld_thr_match_dg;
   input [1:0] wb_byplog_tid_w2;
   input       ld_thr_match_dg2;
   input       ifu_exu_kill_e;
   input       wb_e;            
   input       bypass_m;            
   input       lsu_exu_dfill_vld_g;
   input       bypass_w;
   input       wb_byplog_wen_w2;
   input       wb_byplog_wen_g2;
   input       ecl_byp_ldxa_g;
   output      rs_sel_mux1_m;
   output      rs_sel_mux1_w;
   output      rs_sel_mux1_w2;
   output      rs_sel_mux1_other;
   output      rs_sel_mux2_usemux1;
   output      rs_sel_mux2_rf;
   output      rs_sel_mux2_e;
   output      rs_sel_mux2_ld;
   output      rs_sel_longmux_g2;
   output      rs_sel_longmux_w2;
   output      rs_sel_longmux_ldxa;
   wire        use_e, use_m, use_w, use_w2, use_rf, use_ld, use_ldxa;
   wire         match_e, match_m, match_w, match_w2, match_ld; 
   wire         match_g2;
   wire         bypass;         
   wire         rs_is_nonzero;
   assign       rs_is_nonzero = rs[0]|rs[1]|rs[2]|rs[3]|rs[4];
   assign       bypass = rs_is_nonzero & ~use_other & ~sehold;
   assign       use_e = match_e & wb_e & ~ifu_exu_kill_e;
   assign       use_m = match_m & bypass_m & ~use_e;
   assign       use_w = match_w & bypass_w & ~use_m & ~use_e;
   assign       use_ld = match_ld & lsu_exu_dfill_vld_g & ~ecl_byp_ldxa_g;
   assign       use_ldxa = match_ld & ecl_byp_ldxa_g;
   assign       use_w2 = (match_w2 & wb_byplog_wen_w2 | match_g2 & wb_byplog_wen_g2) & ~use_e & ~use_m;
   assign       use_rf = ~use_w2 & ~use_w & ~use_m & ~use_e & ~use_ld & ~use_ldxa;
   assign       rs_sel_mux2_e = (use_e & bypass);
   assign       rs_sel_mux2_rf = ((use_rf | ~bypass) & ~(use_other & ~sehold));
   assign       rs_sel_mux2_ld = (use_ld & ~use_e & ~use_w & ~use_m & ~use_w2 & bypass);
   assign       rs_sel_mux2_usemux1 = (use_other & ~sehold) | (~rs_sel_mux1_other & ~use_e);
   assign rs_sel_mux1_other = ~((use_m | use_w | use_w2 | use_ldxa) & bypass);
   assign rs_sel_mux1_w2 = ((use_w2 | use_ldxa) & bypass);
   assign rs_sel_mux1_w = (use_w & ~use_w2 & ~use_ldxa & bypass);
   assign rs_sel_mux1_m = (use_m & ~use_w2 & ~use_ldxa & bypass);
   assign rs_sel_longmux_ldxa = use_ldxa;
   assign rs_sel_longmux_g2 = match_g2 & wb_byplog_wen_g2 & ~use_ldxa;
   assign rs_sel_longmux_w2 = ~use_ldxa & ~(match_g2 & wb_byplog_wen_g2);
   assign match_e = thr_match_de & (rs[4:0] == rd_e[4:0]);
   assign match_m = thr_match_dm & (rs[4:0] == rd_m[4:0]);
   sparc_exu_eclcomp7 w_comp7(.out(match_w), .in1({tid_d[1:0],rs[4:0]}),
                              .in2({ecl_irf_tid_w[1:0],ecl_irf_rd_w[4:0]}));
   sparc_exu_eclcomp7 w2_comp7(.out(match_w2), .in1({tid_d[1:0],rs[4:0]}),
                               .in2({wb_byplog_tid_w2[1:0],wb_byplog_rd_w2[4:0]}));
   assign match_ld = ld_thr_match_dg & (rs[4:0] == ld_rd_g[4:0]);
   assign match_g2 = ld_thr_match_dg2 & (rs[4:0] == wb_byplog_rd_g2[4:0]);
endmodule