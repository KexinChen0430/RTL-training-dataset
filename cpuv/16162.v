module need to handle the path from the MOFF domain, which
  assign aon_iso = test_mode ? test_iso_override : aon_io_moff_corerst;
  assign jtagpwd_iso = test_mode ? test_iso_override : aon_io_jtagpwd;
  assign pc_rtvec = aon_io_bootrom ? 32'h0000_1000 :
                                     32'h2000_0000;
endmodule