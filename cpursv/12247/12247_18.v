
module hangcase();

  assign w_rdat_ena = (bar & ((bar & {16{foo[15]}}) | {16{foo[0]}})) | (bar & {16{foo[1]}});
  assign w_rdat_mrk = (({16{foo[0]}} & baz) & (baz & bar)) | ((baz & bar) & {16{foo[15]}});
  assign w_wdat_ena_set = col_dec & {16{ena_set}};
  assign w_wdat_ena_clr = col_dec & {16{ena_clr}};
  assign w_wdat_mrk_set = {16{mrk_set}} & w_rdat_ena;
  assign w_wdat_mrk_clr = col_dec & {16{mrk_clr}};
  assign w_wdat_ena = (w_wdat_ena_set | ~w_wdat_ena_clr) & (w_rdat_ena | w_wdat_ena_set);
  assign w_wdat_mrk = ((~w_wdat_mrk_clr | w_wdat_mrk_set) & w_rdat_mrk) | w_wdat_mrk_set;
  assign w_dat15_ena = foo[15] ? w_wdat_ena : bar;
  assign w_dat15_mrk = foo[15] ? w_wdat_mrk : baz;
  assign w_timeout_mrk = row_check ? w_wdat_mrk : r_timeout_mrk;
endmodule

