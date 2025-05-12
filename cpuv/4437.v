module comparator_counter(
		input wire iCLOCK,
		input wire inRESET,
		input wire iMTIMER_WORKING,
		input wire [63:0] iMTIMER_COUNT,
		input wire iCONF_WRITE,
		input wire iCONF_ENA,
		input wire iCONF_IRQENA,
		input wire iCONF_64MODE,
		input wire iCONF_PERIODIC,
		input wire iCOUNT_WRITE,
		input wire [1:0] inCOUNT_DQM,
		input wire [63:0] iCOUNT_COUNTER,
		output wire oIRQ
	);