module sirv_aon_porrst( 
  output porrst_n 
);
  `ifdef FPGA_SOURCE 
      assign porrst_n = 1'b1; 
  `else 
      assign porrst_n = 1'b1; 
  `endif 
endmodule 