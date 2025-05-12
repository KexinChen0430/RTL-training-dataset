
module mgc_out_stdreg(d,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  input  [width+(0-1):0] d;
  output [width+(0-1):0] z;
  wire [width+(0-1):0] z;

  assign z = d;
endmodule

