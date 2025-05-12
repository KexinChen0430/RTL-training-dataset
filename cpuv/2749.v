module SaturationEnhancement
(
	input signed[ `size_int - 1 : 0 ]CIEa,
	input signed[ `size_int - 1 : 0 ]CIEb,
	output wire signed[ `size_int - 1 : 0 ]CIEa_out,
	output wire signed[ `size_int - 1 : 0 ]CIEb_out
);
	assign	CIEa_out = ( CIEa * `SE_a ) >> `ScaleBit;
	assign	CIEb_out = ( CIEb * `SE_b ) >> `ScaleBit;
endmodule