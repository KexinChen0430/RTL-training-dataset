
module integer1lt;

  integer a;
  integer b;
  reg  error;

  
  initial  
  begin
    error = 0;
    a = 2;
    if (a < 2) 
      begin
        $display("FAILED 2 < 2");
        error = 1;
      end
      
    a = 3;
    if (a < 2) 
      begin
        $display("FAILED 3 < 2");
        error = 1;
      end
      
    a = 1;
    if (a < 2) 
      begin
        b = 1;
      end
    else 
      begin
        $display("FAILED 1 < 2");
        error = 1;
      end
    b = 0;
    for (a = 0; a < 5; a = a+1)
        begin
          b = b+a;
        end
    if (b != 10) 
      begin
        $display("FAILED forloop b=%d expected 10",b);
        error = 1;
      end
      
    if (error == 0) 
      $display(PASSED);
      
    $finish;
  end
endmodule

