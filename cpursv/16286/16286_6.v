
module mgc_chan_in(ld,vd,d,lz,vz,z,size,req_size,sizez,sizelz);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  parameter integer  sz_width = 8;
  input  ld;
  output vd;
  output [(-1)+width:0] d;
  output lz;
  input  vz;
  input  [(-1)+width:0] z;
  output [sz_width-1:0] size;
  input  req_size;
  input  [sz_width-1:0] sizez;
  output sizelz;
  wire vd;
  wire [(-1)+width:0] d;
  wire lz;
  wire [sz_width-1:0] size;
  wire sizelz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;
  assign size = sizez;
  assign sizelz = req_size;
endmodule

