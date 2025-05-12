
module test;

  reg  [3:0] result;
  reg  error;
  integer num1;
  wire [3:0] result1;

  assign result1 = 1+(num1*(1/4));
  
  initial  
  begin
    error = 0;
    num1 = 32'h24;
    result = 1+(num1*(1/4));
    #1 ;
    if (result !== 4'ha) 
      begin
        $display("FAILED - division didn't work s/b A, is %h",result);
        error = 1;
      end
      
    if (result1 !== 4'ha) 
      begin
        $display("FAILED - assign division didn't work s/b A, is %h",
                 result1);
        error = 1;
      end
      
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

