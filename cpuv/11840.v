module. The F17 stage is used to intermittently run the AGC when it operates
wire SL_RSTA = NPURST;								
reg [ 3:0] Mcnt;										
always @(posedge CLK1 or negedge SL_RSTA) 	
   if(!SL_RSTA)      Mcnt <= 4'h0;				
	else if(MCT_PE)   Mcnt <= 4'h0;				
   else if(MCT_CET)  Mcnt <= Mcnt + 4'd1;		
wire MCT_PE  = (Mcnt == 4'd10);					
wire MCT_CET = SCL_ENAB;							
reg [16:0] Fcnt;										
always @(posedge CLK1 or negedge SL_RSTA) 	
   if(!SL_RSTA)      Fcnt <= 17'd0;				
   else if(FCT_CET)  Fcnt <= Fcnt + 17'd1;	
wire FCT_CET = MCT_PE;								
wire   F10X_IN =  Fcnt[ 9];			
wire   F13X_IN =  Fcnt[12];			
wire   F17X_IN =  Fcnt[16];			
wire CLK1N = ~CLK1;                               
reg Q10A, Q10B;										
always@(negedge CLK1N or negedge SL_RSTA)         
    if(!SL_RSTA)  Q10A <= 1'b0;						
    else          Q10A <= ~Q10A & Q10B | Q10A & F10X_IN; 
always@(negedge CLK1N or negedge SL_RSTA)         
    if(!SL_RSTA)  Q10B <= 1'b0;						
    else          Q10B <= ~Q10B & !(Q10A | !F10X_IN) ; 
reg Q13A, Q13B;										
always@(negedge CLK1N or negedge SL_RSTA)         
    if(!SL_RSTA)  Q13A <= 1'b0;						
    else          Q13A <= ~Q13A & Q13B | Q13A & F13X_IN; 
always@(negedge CLK1N or negedge SL_RSTA)         
    if(!SL_RSTA)  Q13B <= 1'b0;						
    else          Q13B <= ~Q13B & !(Q13A | !F13X_IN); 
reg Q17A, Q17B;										
always@(negedge CLK1N or negedge SL_RSTA)         
    if(!SL_RSTA)  Q17A <= 1'b0;						
    else          Q17A <= ~Q17A & Q17B | Q17A & F17X_IN; 
always@(negedge CLK1N or negedge SL_RSTA)         
    if(!SL_RSTA)  Q17B <= 1'b0;						
    else          Q17B <= ~Q17B & !(Q17A | !F17X_IN); 
assign F10X = Q10B;		
assign F13X = Q13B;		
assign F17X = Q17B;		
endmodule