module  arriaii_asmiblock
	(
	dclkin,
	scein,
	sdoin,
	data0in,
	oe,
	dclkout,
	sceout,
	sdoout,
	data0out
	);
input dclkin;
input scein;
input sdoin;
input data0in;
input oe;
output dclkout;
output sceout;
output sdoout;
output data0out;
parameter lpm_type = "arriaii_asmiblock";
endmodule