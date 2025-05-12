
module main;

  reg  [3:0] value1;
  reg  event_var;

  
  initial  
  begin
    #2 ;
    value1 = 5'h0;
    #3 ;
    event_var = 1'b0;
    #2 ;
    value1 = 5'h0;
    #3 ;
    event_var = 1'b1;
    #5 ;
  end
  
  initial  
  begin
    if (value1 !== 4'bxxxx) 
      $display("FAILED - always reg_lvalue = @ (event_expression)  boolean_expr\n");
      
    #6 ;
    if (value1 != 4'h1) 
      $display("FAILED - always reg_lvalue = @ (event_expression)  boolean_expr\n");
      
    #5 ;
    if (value1 != 4'h1) 
      $display("FAILED - always reg_lvalue = @ (event_expression)  boolean_expr\n");
      
    begin
      $display(PASSED\n);
      $finish;
    end
  end
  
  always   value1 = @(event_var) 1'b1;
endmodule

