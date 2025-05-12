
module mgc_in_wire_wait(ld,vd,d,lz,vz,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  input  ld;
  output vd;
  output [(0-1)+width:0] d;
  output lz;
  input  vz;
  input  [(0-1)+width:0] z;
  wire vd;
  wire [(0-1)+width:0] d;
  wire lz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;
endmodule

