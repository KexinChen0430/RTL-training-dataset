
module integer4ge;

  integer a;
  integer b;
  reg  error;

  
  initial  
  begin
    error = 0;
    a = 1;
    if (a >= 1<<<1) 
      begin
        $display("FAILED 1 >= 2");
        error = 1;
      end
      
    a = 1<<<1;
    if (a >= 1<<<1) 
      begin
        b = 1;
      end
    else 
      begin
        $display("FAILED 2 >= 2");
        error = 1;
      end
    a = 3;
    if (a >= 1<<<1) 
      begin
        b = 1;
      end
    else 
      begin
        $display("FAILED 3 >= 2");
        error = 1;
      end
    b = 0;
    for (a = 10; a >= 5; a = a-1)
        begin
          b = a+b;
        end
    if (b != 45) 
      begin
        $display("FAILED forloop b=%d expected 45",b);
        error = 1;
      end
      
    if (error == 0) 
      $display(PASSED);
      
    $finish;
  end
endmodule

