module DSP48A (
    input signed [17:0] A,         
    input signed [17:0] B,         
    input signed [47:0] C,         
    input signed [17:0] D,         
    input signed [47:0] PCIN,      
    input CARRYIN,                 
    input [7:0] OPMODE,            
    output signed [47:0] P,        
    output signed [17:0] BCOUT,    
    output signed [47:0] PCOUT,    
    output CARRYOUT,               
    (* clkbuf_sink *)
    input CLK,                     
    input CEA,                     
    input CEB,                     
    input CEC,                     
    input CED,                     
    input CEM,                     
    input CECARRYIN,               
    input CEOPMODE,                
    input CEP,                     
    input RSTA,                    
    input RSTB,                    
    input RSTC,                    
    input RSTD,                    
    input RSTM,                    
    input RSTCARRYIN,              
    input RSTOPMODE,               
    input RSTP                     
);
parameter integer A0REG = 0;
parameter integer A1REG = 1;
parameter integer B0REG = 0;
parameter integer B1REG = 1;
parameter integer CREG = 1;
parameter integer DREG = 1;
parameter integer MREG = 1;
parameter integer CARRYINREG = 1;
parameter integer OPMODEREG = 1;
parameter integer PREG = 1;
parameter CARRYINSEL = "CARRYIN";
parameter RSTTYPE = "SYNC";
DSP48A1 #(
	.A0REG(A0REG),
	.A1REG(A1REG),
	.B0REG(B0REG),
	.B1REG(B1REG),
	.CREG(CREG),
	.DREG(DREG),
	.MREG(MREG),
	.CARRYINREG(CARRYINREG),
	.CARRYOUTREG(0),
	.OPMODEREG(OPMODEREG),
	.PREG(PREG),
	.CARRYINSEL(CARRYINSEL),
	.RSTTYPE(RSTTYPE)
) upgrade (
	.A(A),
	.B(B),
	.C(C),
	.D(D),
	.PCIN(PCIN),
	.CARRYIN(CARRYIN),
	.OPMODE(OPMODE),
	.P(P),
	.BCOUT(BCOUT),
	.PCOUT(PCOUT),
	.CARRYOUT(CARRYOUT),
	.CLK(CLK),
	.CEA(CEA),
	.CEB(CEB),
	.CEC(CEC),
	.CED(CED),
	.CEM(CEM),
	.CECARRYIN(CECARRYIN),
	.CEOPMODE(CEOPMODE),
	.CEP(CEP),
	.RSTA(RSTA),
	.RSTB(RSTB),
	.RSTC(RSTC),
	.RSTD(RSTD),
	.RSTM(RSTM),
	.RSTCARRYIN(RSTCARRYIN),
	.RSTOPMODE(RSTOPMODE),
	.RSTP(RSTP)
);
endmodule