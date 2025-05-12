
module main;

  reg  [3:0] value1;

  
  initial  
  begin
    value1 = 0;
    #5 ;
    if (value1 != 4'd4) 
      $display("FAILED - always 3.1.5F always if ( bool_expr) statementelse ;");
    else 
      $display(PASSED);
    $finish;
  end
  
  always 
      if (1'b1) 
        begin
          #1 ;
          value1 = 1+value1;
        end
      else value1 = 0;
endmodule

