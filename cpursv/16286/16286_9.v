
module mgc_chan_in(ld,vd,d,lz,vz,z,size,req_size,sizez,sizelz);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  parameter integer  sz_width = 8;
  input  ld;
  output vd;
  output [width-1:0] d;
  output lz;
  input  vz;
  input  [width-1:0] z;
  output [(-1)+sz_width:0] size;
  input  req_size;
  input  [(-1)+sz_width:0] sizez;
  output sizelz;
  wire vd;
  wire [width-1:0] d;
  wire lz;
  wire [(-1)+sz_width:0] size;
  wire sizelz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;
  assign size = sizez;
  assign sizelz = req_size;
endmodule

