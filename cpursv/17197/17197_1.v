
module fpoint_qsys_addsub_single_altpriority_encoder_iha(data,q);

  input  [1:0] data;
  output q;

  assign q = {data[1]};
endmodule

