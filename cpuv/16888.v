module \$_DFFE_PP_ (input D, C, E, output Q);
	DFFE _TECHMAP_REPLACE_ (.D(D), .Q(Q), .CLK(C), .CE(E));
	wire _TECHMAP_REMOVEINIT_Q_ = 1;
endmodule