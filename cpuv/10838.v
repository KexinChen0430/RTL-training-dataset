module \$__div_mod_u (A, B, Y, R);
	parameter WIDTH = 1;
	(* force_downto *)
	input [WIDTH-1:0] A, B;
	(* force_downto *)
	output [WIDTH-1:0] Y, R;
	(* force_downto *)
	wire [WIDTH*WIDTH-1:0] chaindata;
	assign R = chaindata[WIDTH*WIDTH-1:WIDTH*(WIDTH-1)];
	genvar i;
	generate begin
		for (i = 0; i < WIDTH; i=i+1) begin:stage
			(* force_downto *)
			wire [WIDTH-1:0] stage_in;
			if (i == 0) begin:cp
				assign stage_in = A;
			end else begin:cp
				assign stage_in = chaindata[i*WIDTH-1:(i-1)*WIDTH];
			end
			assign Y[WIDTH-(i+1)] = stage_in >= {B, {WIDTH-(i+1){1'b0}}};
			assign chaindata[(i+1)*WIDTH-1:i*WIDTH] = Y[WIDTH-(i+1)] ? stage_in - {B, {WIDTH-(i+1){1'b0}}} : stage_in;
		end
	end endgenerate
endmodule