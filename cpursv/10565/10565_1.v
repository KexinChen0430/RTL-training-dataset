
module altddio_in(datain,inclock,inclocken,aset,aclr,sset,sclr,dataout_h,
                  dataout_l);

  parameter  width = 1;
  parameter  power_up_high = OFF;
  parameter  invert_input_clocks = OFF;
  parameter  intended_device_family = Stratix;
  parameter  lpm_type = altddio_in;
  parameter  lpm_hint = UNUSED;
  input  [width-1:0] datain;
  input  inclock;
  input  inclocken;
  input  aset;
  input  aclr;
  input  sset;
  input  sclr;
  output [width-1:0] dataout_h;
  output [width-1:0] dataout_l;


endmodule

