
module test;

  reg  [3:0] val1;
  reg  [3:0] val2;
  wire [3:0] val3;

  
  initial  
  begin
    #50 ;
    if (val3 !== 4'b1010) 
      $display(FAILED);
    else 
      $display(PASSED);
  end
  
  initial  
  begin
    #20 ;
    force val3 = 4'b1010;
  end
endmodule

