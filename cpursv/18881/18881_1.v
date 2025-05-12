
module main;

  reg  [3:0] value1;

  
  initial  
  begin
    #15 ;
    if (value1 !== 4'b1) 
      $display("FAILED - 3.1.3E always force reg_lvalue = boolean_expr;");
    else 
      $display(PASSED);
    $finish;
  end
  
  always   #10 force value1 = 1'b1;
endmodule

