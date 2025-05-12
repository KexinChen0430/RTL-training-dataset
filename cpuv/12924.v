module 
assign wbck_i_ready  = rf_wbck_o_ready; 
wire rf_wbck_o_valid = wbck_i_valid; 
wire wbck_o_ena   = rf_wbck_o_valid & rf_wbck_o_ready; 
assign rf_wbck_o_ena   = wbck_o_ena & (~wbck_i_rdfpu); 
assign rf_wbck_o_wdat  = wbck_i_wdat[`E203_XLEN-1:0]; 
assign rf_wbck_o_rdidx = wbck_i_rdidx; 
endmodule 