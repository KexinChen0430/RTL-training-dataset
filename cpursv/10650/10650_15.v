
module tornado_epcs_flash_controller_0_atom(dclkin,oe,scein,sdoin,data0out);

  output data0out;
  input  dclkin;
  input  oe;
  input  scein;
  input  sdoin;
  wire data0out;

  assign data0out = (scein | oe) | (sdoin | dclkin);
endmodule

