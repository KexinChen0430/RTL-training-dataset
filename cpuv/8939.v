module RAMB16_S36_S36 (
    CLKA,
    SSRA,
    ADDRA,
    DIA,
    DIPA,
    ENA,
    WEA,
    DOA,
    DOPA,
    CLKB,
    SSRB,
    ADDRB,
    DIB,
    DIPB,
    ENB,
    WEB,
    DOB,
    DOPB
);
parameter dw = 32;
parameter dwp = 4;
parameter aw = 9;
input CLKA, SSRA, ENA, WEA, CLKB, SSRB, ENB, WEB;
input [dw-1:0] DIA, DIB;
output [dw-1:0] DOA, DOB;
input [dwp-1:0] DIPA, DIPB;
output [dwp-1:0] DOPA, DOPB;
input [aw-1:0] ADDRA, ADDRB;
reg	[dw+dwp-1:0]	mem [(1<<aw)-1:0];	
reg	[aw-1:0]	addr_reg_a;		
reg	[aw-1:0]	addr_reg_b;		
assign DOA = mem[addr_reg_a][dw-1:0];
assign DOPA = mem[addr_reg_a][dwp+dw-1:dw];
assign DOB = mem[addr_reg_b][dw-1:0];
assign DOPB = mem[addr_reg_b][dwp+dw-1:dw];
always @(posedge CLKA or posedge SSRA)
    if ( SSRA == 1'b1 )
        addr_reg_a <= #1 {aw{1'b0}};
    else if ( ENA )
        addr_reg_a <= #1 ADDRA;
always @(posedge CLKB or posedge SSRB)
    if ( SSRB == 1'b1 )
        addr_reg_b <= #1 {aw{1'b0}};
    else if ( ENB )
        addr_reg_b <= #1 ADDRB;
always @(posedge CLKA)
	if (ENA && WEA)
		mem[ADDRA] <= #1 { DIPA , DIA };
always @(posedge CLKB)
	if (ENB && WEB)
		mem[ADDRB] <= #1 { DIPB , DIB };
endmodule