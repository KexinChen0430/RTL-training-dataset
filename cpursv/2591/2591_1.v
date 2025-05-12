
module fp_convert_altpriority_encoder_3v7(data,q);

  input  [1:0] data;
  output q;

  assign q = {data[1]};
endmodule

