module \$equiv (A, B, Y); 
input A, B; 
output Y; 
assign Y = (A !== 1'bx && A !== B) ? 1'bx : A;
`ifndef SIMLIB_NOCHECKS
always @* begin 
	if (A !== 1'bx && A !== B) begin
		$display("Equivalence failed!"); 
		$stop; 
	end
end
`endif
endmodule 