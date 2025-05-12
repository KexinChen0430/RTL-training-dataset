
module altiobuf_in(datain,dataout);

  parameter  enable_bus_hold = FALSE;
  parameter  use_differential_mode = FALSE;
  parameter  number_of_channels = 1;
  input  [(-1)+number_of_channels:0] datain;
  output [(-1)+number_of_channels:0] dataout;


endmodule

