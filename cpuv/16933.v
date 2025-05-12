module k580wi53channel(input clk, input c, input gate, output reg cout,
	input addr, input rd, input we_n, input[7:0] idata, output reg[7:0] odata);