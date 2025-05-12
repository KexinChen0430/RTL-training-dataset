
module altddio_out(datain_h,datain_l,outclock,outclocken,aset,aclr,sset,sclr,oe,
                   dataout,oe_out);

  parameter  width = 1;
  parameter  power_up_high = OFF;
  parameter  oe_reg = UNUSED;
  parameter  extend_oe_disable = UNUSED;
  parameter  intended_device_family = Stratix;
  parameter  invert_output = OFF;
  parameter  lpm_type = altddio_out;
  parameter  lpm_hint = UNUSED;
  input  [(0-1)+width:0] datain_h;
  input  [(0-1)+width:0] datain_l;
  input  outclock;
  input  outclocken;
  input  aset;
  input  aclr;
  input  sset;
  input  sclr;
  input  oe;
  output [(0-1)+width:0] dataout;
  output [(0-1)+width:0] oe_out;


endmodule

