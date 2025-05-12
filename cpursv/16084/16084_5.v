
module mgc_in_wire_en(ld,d,lz,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  input  ld;
  output [(0-1)+width:0] d;
  output lz;
  input  [(0-1)+width:0] z;
  wire [(0-1)+width:0] d;
  wire lz;

  assign d = z;
  assign lz = ld;
endmodule

