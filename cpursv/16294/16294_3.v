
module modulario_en_in(vd,d,vz,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  output vd;
  output [width+(0-1):0] d;
  input  vz;
  input  [width+(0-1):0] z;
  wire [width+(0-1):0] d;
  wire vd;

  assign d = z;
  assign vd = vz;
endmodule

