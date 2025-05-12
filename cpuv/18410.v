module main; 
   reg [4:0] foo [0:3][0:7]; 
   bit [3:0] idx1, idx2; 
   initial begin 
      for (idx1 = 0 ; idx1 < 4 ; idx1 = idx1+1) begin 
	 for (idx2 = 0 ; idx2 <= 7 ; idx2 = idx2+1) 
	   foo[idx1][idx2] = {idx1[1:0], idx2[2:0]}; 
      end
      foreach (foo[ia,ib]) begin 
	 if (ia > 3 || ib > 7) begin 
	    $display("FAILED -- index out of range: ia=%0d, ib=%0d", ia, ib); 
	    $finish; 
	 end
	 if (foo[ia][ib] !== {ia[1:0], ib[2:0]}) begin 
	    $display("FAILED -- foo[%0d][%0d] == %b", ia, ib, foo[ia][ib]); 
	    $finish; 
	 end
	 foo[ia][ib] = 5'bzzzz; 
      end
      for (idx1 = 0 ; idx1 < 4 ; idx1 = idx1+1) begin 
	 for (idx2 = 0 ; idx2 <= 7 ; idx2 = idx2+1) 
	   if (foo[idx1][idx2] !== 5'bzzzz) begin 
	      $display("FAILED -- foreach failed to visit foo[%0d][%0d]", idx1,idx2); 
	      $finish; 
	   end
      end
      $display("PASSED"); 
   end 
endmodule 