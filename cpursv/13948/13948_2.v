
module WcaRegisterBus(input  reset,
                      input  csel,
                      input  cpuclock,
                      input  ASTB,
                      input  nOE,
                      input  nWE,
                      input  wire [5:0] abus,
                      inout  wire [15:0] dbus,
                      output wire [12:0] rbusCtrl,
                      inout  wire [15:0] rbusData);

  assign dmaData = dbus;
  assign dmaCtrl[13:10] = 4'd0;
  assign dmaCtrl[9:4] = abus[5:0];
  assign dmaCtrl[3] = csel | ASTB;
  assign dmaCtrl[2] = nOE;
  assign dmaCtrl[1] = nWE;
  assign dmaCtrl[0] = cpuclock;
endmodule

