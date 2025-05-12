module CORDIC (clock, angle, Xin, Yin, Xout, Yout); 
parameter XY_SZ = 16;   
localparam STG = XY_SZ; 
input                      clock; 
input  signed       [31:0] angle; 
input  signed  [XY_SZ-1:0] Xin;   
input  signed  [XY_SZ-1:0] Yin;   
output signed    [XY_SZ:0] Xout;  
output signed    [XY_SZ:0] Yout;  
wire signed [31:0] atan_table [0:30]; 
reg signed [XY_SZ:0] X [0:STG-1]; 
reg signed [XY_SZ:0] Y [0:STG-1]; 
reg signed    [31:0] Z [0:STG-1]; 
wire                 [1:0] quadrant; 
assign   quadrant = angle[31:30]; 
assign Xout = X[STG-1];
assign Yout = Y[STG-1];
endmodule 