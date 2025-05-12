
module mgc_in_wire_en(ld,d,lz,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  input  ld;
  output [(-1)+width:0] d;
  output lz;
  input  [(-1)+width:0] z;
  wire [(-1)+width:0] d;
  wire lz;

  assign d = z;
  assign lz = ld;
endmodule

