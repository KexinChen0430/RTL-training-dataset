
module main;

  reg  [3:0] value1;
  event event_ident;
  
  initial  
  begin
    #5 -> event_ident ;
  end
  
  initial  
  begin
    if (value1 !== 4'bxxxx) 
      $display("FAILED - always reg_lvalue <= @ event_identifier boolean_expression\n");
      
    #10 ;
    if (value1 != 4'b1) 
      $display("FAILED - always reg_lvalue <= @ event_identifier boolean_expression\n");
    else 
      begin
        $display(PASSED\n);
        $finish;
      end
  end
  
  always   value1 <= @event_ident 1'b1;
endmodule

