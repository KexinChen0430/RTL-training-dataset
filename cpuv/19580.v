module x; 
   output                              sig1; 
   output [A-1:0]                      sig2; 
   output [A-1:0][B-1:0]               sig3; 
   output [A-1:0][B-1:0][C-1:0]        sig4; 
   output [A-1:0][B-1:0][C-1:0][D-1:0] sig5; 
   output                              vsig1; 
   output                              vsig2 [W-1:0]; 
   output                              vsig3 [W-1:0][X-1:0]; 
   output                              vsig4 [W-1:0][X-1:0][Y-1:0]; 
   output                              vsig5 [W-1:0][X-1:0][Y-1:0][Z-1:0]; 
   output                              zsig1; 
   output [A-1:0]                      zsig2 [W-1:0]; 
   output [A-1:0][B-1:0]               zsig3 [W-1:0][X-1:0]; 
   output [A-1:0][B-1:0][C-1:0]        zsig4 [W-1:0][X-1:0][Y-1:0]; 
   output [A-1:0][B-1:0][C-1:0][D-1:0] zsig5 [W-1:0][X-1:0][Y-1:0][Z-1:0]; 
endmodule 