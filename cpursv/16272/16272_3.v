
module hid_tribuf(I_SIG,ENABLE,O_SIG);

  parameter integer  width = 8;
  input  [(-1)+width:0] I_SIG;
  input  ENABLE;
  inout  [(-1)+width:0] O_SIG;

  assign O_SIG = ENABLE ? I_SIG : {width{1'bz}};
endmodule

