
module main;

  reg  [3:0] value1,value2,value3;

  
  always 
      begin
        #5 ;
        value1 = 1;
      end
  
  initial  
  begin
    value1 = 0;
    value2 = 0;
    if (value1 != 0) 
      begin
        $display("FAILED - 3.1.11A always begin statement end");
        value2 = 1;
      end
      
    #6 ;
    if (value1 != 1) 
      begin
        $display("FAILED - 3.1.11A always begin statement end");
        value2 = 1;
      end
      
    if (value2 == 0) 
      $display(PASSED);
      
    $finish;
  end
endmodule

