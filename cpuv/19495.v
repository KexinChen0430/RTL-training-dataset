module test; 
parameter A0 = ~(4'b1010);
initial
  begin
   if(A0 !== 4'b0101)
      $display("FAILED - Bit vector inversion in a param declaration.");
   else
      $display("PASSED");
  end 
endmodule 