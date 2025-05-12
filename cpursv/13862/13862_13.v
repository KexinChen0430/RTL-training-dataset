
module tornado_epcs_controller_atom(input  dclkin,
                                    input  oe,
                                    input  scein,
                                    input  sdoin,
                                    output data0out);

  wire data0out;
  input  dclkin;
  input  oe;
  input  scein;
  input  sdoin;

  assign data0out = (dclkin | (oe | scein)) | sdoin;
endmodule

