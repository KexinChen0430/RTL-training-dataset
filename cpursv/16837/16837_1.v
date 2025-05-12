
module fpoint_hw_qsys_addsub_single_altpriority_encoder_i0b(data,q,zero);

  input  [1:0] data;
  output q;
  output zero;

  assign q = {data[1]},
         zero = ~(data[0] | data[1]);
endmodule

