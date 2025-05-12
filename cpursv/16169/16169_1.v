
module funccall_inout(d,ad,bd,z,az,bz);

  parameter integer  ram_id = 1;
  parameter integer  width = 8;
  parameter integer  addr_width = 8;
  output [(-1)+width:0] d;
  input  [(-1)+addr_width:0] ad;
  input  bd;
  input  [(-1)+width:0] z;
  output [(-1)+addr_width:0] az;
  output bz;
  wire [(-1)+width:0] d;
  wire [(-1)+addr_width:0] az;
  wire bz;

  assign d = z;
  assign az = ad;
  assign bz = bd;
endmodule

