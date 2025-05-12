
module mgc_out_prereg_en(ld,d,lz,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  input  ld;
  input  [(0-1)+width:0] d;
  output lz;
  output [(0-1)+width:0] z;
  wire lz;
  wire [(0-1)+width:0] z;

  assign z = d;
  assign lz = ld;
endmodule

