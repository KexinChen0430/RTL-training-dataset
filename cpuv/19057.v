module test;
   wire q;
   reg  a, b;
   xor #1 (q, a, b);
   reg	error;
   initial
     begin
	error = 0;
	#2;
	@(q);
	error = 1;
	$display("%0d: FAILED: q=%b", $time, q);
     end
   initial
     begin
	a = 0;
	b = 1;
	#3;
	a = 1;
	b = 0;
	#2;
	a = 0;
	b = 1;
	#3;
	if (!error)
	  $display("PASSED");
     end
endmodule