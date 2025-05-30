
module mgc_out_stdreg_wait(ld,vd,d,lz,vz,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  input  ld;
  output vd;
  input  [width+(0-1):0] d;
  output lz;
  input  vz;
  output [width+(0-1):0] z;
  wire vd;
  wire lz;
  wire [width+(0-1):0] z;

  assign z = d;
  assign lz = ld;
  assign vd = vz;
endmodule

