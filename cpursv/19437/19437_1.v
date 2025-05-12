
module main();

  parameter  VAL_1 = 16'h0001;
  parameter  VAL_2 = 16'h5432;
  reg  [15:0] test_var;

  
  initial  
  begin
    test_var = VAL_1;
    #5 ;
    test_var = VAL_2;
    #5 ;
  end
  
  initial  
  begin
    #1 ;
    if (test_var != 16'h0001) 
      begin
        $display("FAILED - param 1st assign didn't work\n");
        $finish;
      end
      
    #5 ;
    if (test_var != 16'h5432) 
      begin
        $display("FAILED - param 2nd assign didn't work\n");
        $finish;
      end
      
    $display(PASSED\n);
    $finish;
  end
endmodule

