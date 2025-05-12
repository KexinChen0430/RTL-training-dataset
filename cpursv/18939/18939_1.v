
module ifdef1;

  reg  error;

  
  initial  
  begin
    #1 ;
    error = 0;
    #40 ;
    if (error == 0) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

