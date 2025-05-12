
module altiobuf_bidir(dataio,oe,datain,dataout);

  parameter  number_of_channels = 1;
  parameter  enable_bus_hold = "OFF";
  inout  [number_of_channels-1:0] dataio;
  input  [number_of_channels-1:0] datain;
  output [number_of_channels-1:0] dataout;
  input  [number_of_channels-1:0] oe;


endmodule

