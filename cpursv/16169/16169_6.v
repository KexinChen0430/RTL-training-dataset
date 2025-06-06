
module funccall_inout(d,ad,bd,z,az,bz);

  parameter integer  ram_id = 1;
  parameter integer  width = 8;
  parameter integer  addr_width = 8;
  output [(-1)+width:0] d;
  input  [addr_width-1:0] ad;
  input  bd;
  input  [(-1)+width:0] z;
  output [addr_width-1:0] az;
  output bz;
  wire [(-1)+width:0] d;
  wire [addr_width-1:0] az;
  wire bz;

  assign d = z;
  assign az = ad;
  assign bz = bd;
endmodule

