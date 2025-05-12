
module fpoint_hw_qsys_addsub_single_altpriority_encoder_6la(data,q);

  input  [1:0] data;
  output q;

  assign q = {~data[0]};
endmodule

