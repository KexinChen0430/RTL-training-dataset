
module mgc_inout_stdreg_en(ldin,din,ldout,dout,lzin,lzout,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  input  ldin;
  output [(0-1)+width:0] din;
  input  ldout;
  input  [(0-1)+width:0] dout;
  output lzin;
  output lzout;
  inout  [(0-1)+width:0] z;
  wire [(0-1)+width:0] din;
  wire lzin;
  wire lzout;
  wire [(0-1)+width:0] z;

  assign lzin = ldin;
  assign din = ldin ? z : {width{1'bz}};
  assign lzout = ldout;
  assign z = ldout ? dout : {width{1'bz}};
endmodule

