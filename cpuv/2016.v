module IOBUF_ANALOG #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED", 
`endif
  parameter integer DRIVE = 12, 
  parameter IBUF_LOW_PWR = "TRUE", 
  parameter IOSTANDARD = "DEFAULT", 
  parameter SLEW = "SLOW" 
)(
  output O, 
  inout IO, 
  input I, 
  input T 
);