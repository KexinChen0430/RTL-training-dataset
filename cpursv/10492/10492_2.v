
module altiobuf_out(datain,dataout);

  parameter  enable_bus_hold = FALSE;
  parameter  use_differential_mode = FALSE;
  parameter  use_oe = FALSE;
  parameter  number_of_channels = 1;
  input  [number_of_channels+(0-1):0] datain;
  output [number_of_channels+(0-1):0] dataout;


endmodule

