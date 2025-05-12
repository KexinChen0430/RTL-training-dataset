module IOBUF (O, IO, I, OEN);
  input I;       
  input OEN;     
  output O;      
  inout IO;      
  assign IO = OEN ? I : 1'bz;
  assign I = IO; 
endmodule