module tb_fifo();
	reg a;
	reg b;
	reg c;
	reg d;
	reg e;
	reg [1:0] opA;
	reg opB;
	reg opC;
	reg [0:7] alicia;
	reg [0:7] lowery;
	reg [0:7] patrice;
	initial
	begin
		opA=1;
		opB=0;
		opC=1;
		$display("opA",opA);
		#10
		opA=3;
		opB=2;
		opC=0;
		opA = (opB>opC) ? 2'd0 : (opA==opB) ? 2'd1 : 2'd2;
		$display("opA",opA);
		#10
		opA=2;
		opB=2;
		opC=3;
		opA = (opB<opC) ? 2'd0 : (opA==opB) ? 2'd1 : 2'd2;
		$display("opA",opA);
		#20
		alicia=8'b10110101;
		lowery=8'b00000100;
		patrice={lowery[0:2],{alicia}};
		#20
		alicia=8'b10110101;
		lowery=8'b00000100;
		patrice={{alicia},lowery[0:2]};
		#20
		alicia=8'b11010100;
		$display("a[0]",alicia[0],"a[6]",alicia[6]);
		#30
		$display($time, " << Finishing the simulation >>");
		$finish;
	end
endmodule