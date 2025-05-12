module flag (invalid, overflow, inexact, underflow, tiny, specialcase, flags); 
  input			invalid;	
  input			overflow;	
  input			inexact;	
  input			specialcase;	
  input			underflow;	
  input			tiny;		
  output [`WFLAG-1:0]	flags;		
  assign flags[`DIVZERO]	= 1'b0; 
  assign flags[`INVALID]	= invalid; 
  assign flags[`INEXACT]	= ~specialcase & (inexact | underflow | overflow); 
  assign flags[`OVERFLOW]	= ~specialcase & overflow; 
  assign flags[`UNDERFLOW]	= tiny; 
endmodule 