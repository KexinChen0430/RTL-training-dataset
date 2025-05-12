module dataGenerator (
	input nReset,
	input clock,
	input [9:0] adc_databus,
	input testModeFlag,
	output [9:0] dataOut
);