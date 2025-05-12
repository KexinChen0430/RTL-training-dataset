
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

  assign data0out = (sdoin | dclkin) | (scein | oe);
endmodule

