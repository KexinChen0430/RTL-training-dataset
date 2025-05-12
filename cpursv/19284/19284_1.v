
module test;

  parameter  A0 = |4'b0001;

  
  initial  
  begin
    if (A0 !== 1'b1) 
      $display("FAILED - bit-wise and in an expression .");
    else 
      $display(PASSED);
  end
endmodule

