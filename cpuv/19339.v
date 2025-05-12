module test; 
   reg a,b; 
   integer x; 
   initial begin 
      x=10; 
      a=x; 
      b = ~x; 
      if (b === 1'b1) 
	$display("PASSED"); 
      else
	$display("FAILED --- b = %b", b); 
   end 
endmodule 