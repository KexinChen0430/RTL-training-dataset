module Tristate(a, b, c, d, dir);
	(* LOC = "P19" *)
	(* PULLDOWN = "10k" *)
	inout wire a;
	(* LOC = "P18" *)
	(* PULLDOWN = "10k" *)
	inout wire b;
	(* LOC = "P17" *)
	(* PULLDOWN = "10k" *)
	input wire d;
	(* LOC = "P16" *)
	output wire c;
	(* LOC = "P15" *)
	(* PULLDOWN = "10k" *)
	input wire dir;
	assign a = dir ? b|d : 1'bz;
	assign b = ~dir ? ~a : 1'bz;
	assign c = dir ? a & b : 1'bz;
endmodule