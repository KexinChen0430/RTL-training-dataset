module assemble(roundprod, special, y, sign, specialsign,
		shiftexp, specialcase, specialsigncase,
		roundmode, overflow);
  input	[`WSIG-1:0] 	roundprod;	
  input	[`WIDTH-2:0]	special;	
  output [`WIDTH-1:0] 	y;		
  input			sign;		
  input			specialsign;	
  input	[`WEXP-1:0] 	shiftexp;	
  input			specialcase;	
  input			specialsigncase; 
  input	[1:0]		roundmode;	
  input			overflow;	
  wire	[`WIDTH-2:0]	rounded;	
  wire	[`WIDTH-2:0]	overflowvalue;	
  wire			undenormed;	
  assign rounded[`WSIG-1:0]	= roundprod;
  assign rounded[`WIDTH-2:`WIDTH-`WEXP-1] = shiftexp;
  assign overflowvalue[`WIDTH-2:0] = roundmode[1] ?
				(sign ^ roundmode[0] ? `CONSTLARGEST : `CONSTINFINITY) :
				(roundmode[0] ? `CONSTLARGEST: `CONSTINFINITY);
  assign y[`WIDTH-1]	= specialsigncase ? specialsign : sign;
  assign y[`WIDTH-2:0]	= specialcase ? special[`WIDTH-2:0] :
				(overflow ? overflowvalue[`WIDTH-2:0] :
				rounded[`WIDTH-2:0]);
endmodule