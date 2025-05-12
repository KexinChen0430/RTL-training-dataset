
module ifdef2;

  reg  error;

  
  initial  
  begin
    #1 ;
    error = 1;
    #40 ;
    if (error == 0) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

