module OBUFTDS (
  input  I,   
  input  T,   
  (* iopad_external_pin *) 
  output O,   
  (* iopad_external_pin *) 
  output OB   
);
  parameter IOSTANDARD  = "DEFAULT"; 
  parameter SLEW        = "SLOW";    
  parameter PULLTYPE    = "NONE";    
  parameter IO_LOC_PAIRS = "";       
  parameter HAS_OSERDES = 0;         
  assign O  = (T == 1'b0) ?  I : 1'bz; 
  assign OB = (T == 1'b0) ? ~I : 1'bz; 
endmodule 