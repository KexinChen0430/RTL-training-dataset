
module main;

  reg  [3:0] value1,value2,value3;

  
  initial  
  begin
    value1 = 0;
    value2 = 0;
    #6 ;
    if (value1 != 4'h1) 
      begin
        $display("FAILED - 3.1.7D always for (1)");
        value2 = 1;
      end
      
    #5 ;
    if (value1 != 4'h2) 
      begin
        $display("FAILED - 3.1.7D always for (2) ");
        value2 = 1;
      end
      
    #5 ;
    if (value1 != 4'h3) 
      begin
        $display("FAILED - 3.1.7D always for (3) ");
        value2 = 1;
      end
      
    if (value2 == 0) 
      $display(PASSED);
      
    $finish;
  end
  
  always 
      for (value1 = 0; value1 <= 5; value1 = 1+value1)
          #5 ;
endmodule

