
module mgc_out_stdreg_en(ld,d,lz,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  input  ld;
  input  [width+(0-1):0] d;
  output lz;
  output [width+(0-1):0] z;
  wire lz;
  wire [width+(0-1):0] z;

  assign z = d;
  assign lz = ld;
endmodule

