
module mgc_out_stdreg_wait(ld,vd,d,lz,vz,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  input  ld;
  output vd;
  input  [(-1)+width:0] d;
  output lz;
  input  vz;
  output [(-1)+width:0] z;
  wire vd;
  wire lz;
  wire [(-1)+width:0] z;

  assign z = d;
  assign lz = ld;
  assign vd = vz;
endmodule

