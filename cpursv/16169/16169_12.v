
module funccall_inout(d,ad,bd,z,az,bz);

  parameter integer  ram_id = 1;
  parameter integer  width = 8;
  parameter integer  addr_width = 8;
  output [width-1:0] d;
  input  [(0-1)+addr_width:0] ad;
  input  bd;
  input  [width-1:0] z;
  output [(0-1)+addr_width:0] az;
  output bz;
  wire [width-1:0] d;
  wire [(0-1)+addr_width:0] az;
  wire bz;

  assign d = z;
  assign az = ad;
  assign bz = bd;
endmodule

