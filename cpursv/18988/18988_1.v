
module test;

  integer a;
  integer b;
  wire result;
  integer error;

  assign result = a <= b;
  
  initial  
  begin
    a = 0;
    b = 0;
    error = 0;
    #5 ;
    if (result !== 1'b1) error = 1;
      
    a = 1;
    #5 ;
    if (result !== 1'b0) error = 1;
      
    b = 1;
    #5 ;
    if (result !== 1'b1) error = 1;
      
    a = 1001;
    b = 1002;
    #5 ;
    if (result !== 1'b1) error = 1;
      
    a = 1003;
    #5 ;
    if (result !== 1'b0) error = 1;
      
    if (error === 0) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

