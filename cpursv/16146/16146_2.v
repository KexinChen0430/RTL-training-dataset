
module mgc_out_stdreg(d,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  input  [(0-1)+width:0] d;
  output [(0-1)+width:0] z;
  wire [(0-1)+width:0] z;

  assign z = d;
endmodule

