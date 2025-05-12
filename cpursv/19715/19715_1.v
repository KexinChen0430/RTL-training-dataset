
module main;

  reg  [3:0] value1;

  
  initial    if (value1 != 4'b1) 
    $display("FAILED - 3.1.1B always reg_lvalue = boolean_expression\n");
  else 
    begin
      $display(PASSED\n);
      $finish;
    end
  
  always   value1 = 1'b1;
endmodule

