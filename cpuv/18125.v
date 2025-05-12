module t (
    input t__aa_bbbbbbb_ccccc xxxxxxx_yyyyy_zzzz,
    output logic [15:0] datao_pre
);
   always_comb 
       datao_pre = { xxxxxxx_yyyyy_zzzz.dddddd.b1.fbyte, xxxxxxx_yyyyy_zzzz.dddddd.c1 };
endmodule