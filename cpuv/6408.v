module Bit(input in, clock, load, output out);
	DFF dff1(in, clock, load, out);
endmodule