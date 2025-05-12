module test; 
parameter A0 = 2'b10 & 2'b11 ; 
initial 
  begin 
   if(A0 !== 2'b10) 
      $display("FAILED - A0 expression AND doesn't work."); 
   else 
      $display("PASSED"); 
  end 
endmodule 