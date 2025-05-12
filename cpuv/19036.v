module exponent(expa, expb, expsum, twoormore, tiny);
  input	[`WEXPSUM-1:0]	expa, expb;
  input			twoormore;
  output [`WEXPSUM-1:0]	expsum;
  output		tiny;
  assign expsum = expa + expb - `BIAS + twoormore;
  assign tiny	= ~|expsum[`WEXPSUM-2:0] | expsum[`WEXPSUM-1];
endmodule