module MULT18X18SIO (
    input signed [17:0] A, 
    input signed [17:0] B, 
    output signed [35:0] P, 
    (* clkbuf_sink *)
    input CLK, 
    input CEA, 
    input CEB, 
    input CEP, 
    input RSTA, 
    input RSTB, 
    input RSTP, 
    input signed [17:0] BCIN, 
    output signed [17:0] BCOUT 
);
parameter integer AREG = 1; 
parameter integer BREG = 1; 
parameter B_INPUT = "DIRECT"; 
parameter integer PREG = 1; 
wire signed [35:0] P_MULT; 
wire signed [17:0] A_MULT; 
wire signed [17:0] B_MULT; 
assign P_MULT = A_MULT * B_MULT; 
assign BCOUT = B_MULT; 
wire signed [17:0] B_MUX; 
assign B_MUX = (B_INPUT == "DIRECT") ? B : BCIN; 
reg signed [17:0] A_REG; 
reg signed [17:0] B_REG; 
reg signed [35:0] P_REG; 
initial begin
	A_REG = 0; 
	B_REG = 0; 
	P_REG = 0; 
end
always @(posedge CLK) begin 
	if (RSTA) 
		A_REG <= 0; 
	else if (CEA) 
		A_REG <= A; 
	if (RSTB) 
		B_REG <= 0; 
	else if (CEB) 
		B_REG <= B_MUX; 
	if (RSTP) 
		P_REG <= 0; 
	else if (CEP) 
		P_REG <= P_MULT; 
end
assign A_MULT = (AREG == 1) ? A_REG : A; 
assign B_MULT = (BREG == 1) ? B_REG : B_MUX; 
assign P = (PREG == 1) ? P_REG : P_MULT; 
endmodule