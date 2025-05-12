
module altddio_bidir(datain_h,datain_l,inclock,inclocken,outclock,outclocken,aset,
                     aclr,sset,sclr,oe,dataout_h,dataout_l,combout,oe_out,
                     dqsundelayedout,padio);

  parameter  width = 1;
  parameter  power_up_high = OFF;
  parameter  oe_reg = UNUSED;
  parameter  extend_oe_disable = UNUSED;
  parameter  implement_input_in_lcell = UNUSED;
  parameter  invert_output = OFF;
  parameter  intended_device_family = Stratix;
  parameter  lpm_type = altddio_bidir;
  parameter  lpm_hint = UNUSED;
  input  [(-1)+width:0] datain_h;
  input  [(-1)+width:0] datain_l;
  input  inclock;
  input  inclocken;
  input  outclock;
  input  outclocken;
  input  aset;
  input  aclr;
  input  sset;
  input  sclr;
  input  oe;
  output [(-1)+width:0] dataout_h;
  output [(-1)+width:0] dataout_l;
  output [(-1)+width:0] combout;
  output [(-1)+width:0] oe_out;
  output [(-1)+width:0] dqsundelayedout;
  inout  [(-1)+width:0] padio;


endmodule

