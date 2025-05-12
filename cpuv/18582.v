module main; 
   reg A, B; 
   reg result1; 
   wire result2 = A ~& B; 
   initial 
     begin
	A = 0; 
	B = 0; 
	#1 result1 = A ~& B; 
	if (result1 !== 1'b1) begin 
	   $display("FAILED"); 
	   $finish; 
	end
	if (result2 !== 1'b1) begin 
	   $display("FAILED"); 
	   $finish; 
	end
	A = 1; 
	#1 result1 = A ~& B; 
	if (result1 !== 1'b1) begin 
	   $display("FAILED"); 
	   $finish; 
	end
	if (result2 !== 1'b1) begin 
	   $display("FAILED"); 
	   $finish; 
	end
	B = 1; 
	#1 result1 = A ~& B; 
	if (result1 !== 1'b0) begin 
	   $display("FAILED"); 
	   $finish; 
	end
	if (result2 !== 1'b0) begin 
	   $display("FAILED"); 
	   $finish; 
	end
	A = 0; 
	#1 result1 = A ~& B; 
	if (result1 !== 1'b1) begin 
	   $display("FAILED"); 
	   $finish; 
	end
	if (result2 !== 1'b1) begin 
	   $display("FAILED"); 
	   $finish; 
	end
	$display("PASSED"); 
     end 
endmodule 