module	\$_SDFF_PP1_ (input D, C, R, output Q); 
	DFFS _TECHMAP_REPLACE_ (.D(D), .Q(Q), .CLK(C), .SET(R)); 
	wire _TECHMAP_REMOVEINIT_Q_ = 1; 
endmodule 