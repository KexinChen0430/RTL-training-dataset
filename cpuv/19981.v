module test; 
parameter A0 = (3'b1zx === 3'b1zx);
initial 
  begin 
   if(A0 !== 1'b1)
      $display("FAILED - Expression equivalence fails in a parameter."); 
   else
      $display("PASSED"); 
  end 
endmodule 