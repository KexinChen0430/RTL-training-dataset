module main; 
   reg [8*6:1] foo; 
   initial 
     begin
	foo = "PASSED"; 
	$display("%s", foo); 
     end
endmodule 