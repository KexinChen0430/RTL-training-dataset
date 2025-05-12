module IOBUFDS (
  input  I,  
  input  T,  
  output O,  
    (* iopad_external_pin *)
  inout  IO,  
    (* iopad_external_pin *)
  inout  IOB  
);
  parameter IOSTANDARD = "DIFF_SSTL135";  
  parameter SLEW = "SLOW";
  parameter IN_TERM = "NONE";  
  parameter PULLTYPE = "NONE"; 
  parameter IO_LOC_PAIRS = ""; 
endmodule