
module fpadd_altpriority_encoder_nh8(data,q,zero);

  input  [1:0] data;
  output q;
  output zero;

  assign q = {~data[0]},
         zero = ~(data[1] | data[0]);
endmodule

