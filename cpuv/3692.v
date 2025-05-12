module PRESENT_ENCRYPT_PBOX(
   output [63:0] odat, 
   input  [63:0] idat  
);
assign odat[0 ] = idat[0 ]; 
assign odat[16] = idat[1 ]; 
assign odat[32] = idat[2 ]; 
assign odat[48] = idat[3 ]; 
assign odat[1 ] = idat[4 ]; 
assign odat[17] = idat[5 ]; 
assign odat[33] = idat[6 ]; 
assign odat[49] = idat[7 ]; 
assign odat[2 ] = idat[8 ]; 
assign odat[18] = idat[9 ]; 
assign odat[14] = idat[56]; 
assign odat[30] = idat[57]; 
assign odat[46] = idat[58]; 
assign odat[62] = idat[59]; 
assign odat[15] = idat[60]; 
assign odat[31] = idat[61]; 
assign odat[47] = idat[62]; 
assign odat[63] = idat[63]; 
endmodule