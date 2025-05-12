module TRIBUFF (
	input D,       
	input E,       
	(* iopad_external_pin *) 
	output PAD     
);
	assign PAD = E ? D : 1'bz;
endmodule 