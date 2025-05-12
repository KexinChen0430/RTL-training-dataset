module IDDRX2DQA(
	input D, DQSR90, ECLK, SCLK, RST, 
	input RDPNTR2, RDPNTR1, RDPNTR0, WRPNTR2, WRPNTR1, WRPNTR0, 
	output Q0, Q1, Q2, Q3, QWL 
);
	parameter GSR = "ENABLED"; 
endmodule