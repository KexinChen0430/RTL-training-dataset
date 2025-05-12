module arr_real(output wire real out, input wire in);
  real rval;
  assign out = rval;
  always @(posedge in)
    rval = rval + 1;
endmodule