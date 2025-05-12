
module main;

  reg  [3:0] value1,value2,value3;

  
  always 
      
      fork
          #5 value1 = 1;
          #8 value1 = 2;
      join

  
  initial  
  begin
    value1 = 0;
    value2 = 0;
    #4 ;
    if (value1 != 0) 
      begin
        $display("FAILED - 3.1.12A always fork statements join (0)");
        value2 = 1;
      end
      
    #2 ;
    if (value1 != 1) 
      begin
        $display("FAILED - 3.1.12A always fork statements join (1)");
        value2 = 1;
      end
      
    #3 ;
    if (value1 != 2) 
      begin
        $display("FAILED - 3.1.12A always fork statements join (2)");
        value2 = 1;
      end
      
    #5 ;
    if (value1 != 1) 
      begin
        $display("FAILED - 3.1.12A always fork statements join (3)");
        value2 = 1;
      end
      
    if (value2 == 0) 
      $display(PASSED);
      
    $finish;
  end
endmodule

