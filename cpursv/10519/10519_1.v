
module altiobuf_bidir(dataio,oe,datain,dataout);

  parameter  number_of_channels = 1;
  parameter  enable_bus_hold = OFF;
  inout  [(0-1)+number_of_channels:0] dataio;
  input  [(0-1)+number_of_channels:0] datain;
  output [(0-1)+number_of_channels:0] dataout;
  input  [(0-1)+number_of_channels:0] oe;


endmodule

