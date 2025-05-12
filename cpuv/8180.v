module ng_SCL(
	input CLK1,				
	input NPURST,			
	input SCL_ENAB,		
	output F10X,			
	output F13X,			
	output F17X			
);
wire SL_RSTA = NPURST;		
reg [ 3:0] Mcnt;			
always @(posedge CLK1 or negedge SL_RSTA) 	
   if(!SL_RSTA)       Mcnt <= 4'h0;		
	else if(MCT_PE)   Mcnt <= 4'h0;		
   else if(MCT_CET)  Mcnt <= Mcnt + 4'd1;	
wire MCT_PE  = Mcnt[0] & Mcnt[3];		
wire MCT_CET = SCL_ENAB;			
reg [16:0] Fcnt;			
always @(posedge CLK1 or negedge SL_RSTA) 	
   if(!SL_RSTA)      Fcnt <= 17'd0;		
   else if(FCT_CET)  Fcnt <= Fcnt + 17'd1;	
wire FCT_CET = MCT_PE;			
wire F10X_IN =  Fcnt[ 9];		
wire F13X_IN =  Fcnt[12];		
wire F17X_IN =  Fcnt[16];		
reg Q10A, Q10B;			
always@(negedge CLK1 or negedge SL_RSTA)	
    if(!SL_RSTA)  Q10A <= 1'b0;		
    else          Q10A <= ~Q10A & Q10B | Q10A & F10X_IN;	
always@(negedge CLK1 or negedge SL_RSTA)	
    if(!SL_RSTA)  Q10B <= 1'b0;		
    else          Q10B <= ~Q10B & !(Q10A | !F10X_IN);	
wire J10A = Q10B;			
wire K10A = !F10X_IN;		
wire J10B = !(Q10A | !F10X_IN);	
wire K10B = Q10B;			
assign F10X = Q10B;		
assign F13X = Q13B;		
assign F17X = Q17B;		
endmodule