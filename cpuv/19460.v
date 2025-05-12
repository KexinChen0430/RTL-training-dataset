module eeq; 
   reg [3:0] a, b; 
   wire eeq = a === b; 
`ifdef DONT_TEST_NEE 
   wire nee = ~(a === b); 
`else 
   wire nee = a !== b; 
`endif 
   reg err; 
   always 
     begin
	#2; 
	$display("%b %b ===%b !==%b", a, b, eeq, nee); 
	if (((a === b) !== eeq) || ((a !== b) !== nee)) err = 1; 
     end
   initial 
     begin
	err = 0; 
	#1 a = 4'b zx10; b = 4'b zx10; #1; 
	#1 a = 4'b 1x10; b = 4'b zx10; #1;
	#1 a = 4'b xz10; b = 4'b zx10; #1;
	#1 a = 4'b xz01; b = 4'b zx10; #1;
	#1 a = 4'b 0000; b = 4'b 0000; #1;
	#1 a = 4'b 1111; b = 4'b 1111; #1;
	#1 a = 4'b xxxx; b = 4'b xxxx; #1;
	#1 a = 4'b zzzz; b = 4'b zzzz; #1;
	#1; 
	if (err) 
	  $display("FAILED"); 
	else
	  $display("PASSED"); 
	$finish; 
     end
endmodule 