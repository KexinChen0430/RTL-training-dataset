
module test;

  parameter  A0 = 4'b0011+4'b0001;

  
  initial  
  begin
    if (A0 !== 4'b0100) 
      $display("FAILED - Addition in a param declaration.");
    else 
      $display(PASSED);
  end
endmodule

