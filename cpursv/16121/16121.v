
module pri_encoder(fract_in,fi_ldz);

  input  [47:0] fract_in;
  output [5:0] fi_ldz;
  reg  [5:0] fi_ldz_r0;

  assign fi_ldz = fi_ldz_r0;
  
  always @(fract_in)  begin

  end
endmodule

