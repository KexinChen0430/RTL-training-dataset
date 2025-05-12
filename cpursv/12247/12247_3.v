
module hangcase();

  assign w_rdat_ena = (({16{foo[0]}} | {16{foo[15]}}) | ({16{foo[1]}} & bar)) & bar;
  assign w_rdat_mrk = baz & (((({16{foo[0]}} & bar) & ((({16{foo[15]}} | (baz & {16{foo[0]}})) & bar) | (({16{foo[15]}} | (baz & {16{foo[0]}})) & {16{foo[15]}}))) & baz) | ({16{foo[15]}} & bar));
  assign w_wdat_ena_set = {16{ena_set}} & col_dec;
  assign w_wdat_ena_clr = col_dec & {16{ena_clr}};
  assign w_wdat_mrk_set = {16{mrk_set}} & w_rdat_ena;
  assign w_wdat_mrk_clr = {16{mrk_clr}} & col_dec;
  assign w_wdat_ena = (w_wdat_ena_set | ~w_wdat_ena_clr) & ((w_wdat_ena_set | w_wdat_ena_set) | w_rdat_ena);
  assign w_wdat_mrk = (w_rdat_mrk | w_wdat_mrk_set) & (w_wdat_mrk_set | ~w_wdat_mrk_clr);
  assign w_dat15_ena = foo[15] ? w_wdat_ena : bar;
  assign w_dat15_mrk = foo[15] ? w_wdat_mrk : baz;
  assign w_timeout_mrk = row_check ? w_wdat_mrk : r_timeout_mrk;
endmodule

