
module modulario_en_in(vd,d,vz,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  output vd;
  output [(0-1)+width:0] d;
  input  vz;
  input  [(0-1)+width:0] z;
  wire [(0-1)+width:0] d;
  wire vd;

  assign d = z;
  assign vd = vz;
endmodule

