
module IBUF_ANALOG(output O,
                   input  I);

  localparam  MODULE_NAME = IBUF_ANALOG;
  tri0  glblGSR = glbl.GSR;

  assign O = I;
endmodule

