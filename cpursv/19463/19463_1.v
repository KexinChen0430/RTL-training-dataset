
module test;

  reg  [3:0] val1;
  reg  [3:0] val2;

  
  initial  
  begin
    val2 = 0;
    #50 ;
    if (val2 !== 4'b1010) 
      $display(FAILED);
    else 
      $display(PASSED);
  end
  
  initial  
  begin
    #20 ;
    force val2 = 4'b1010;
  end
endmodule

