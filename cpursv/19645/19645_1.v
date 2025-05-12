
module main;

  reg  [7:0] x;
  reg  [7:0] y;
  reg  [2:0] i;
  reg  error;

  
  initial  
  begin
    #5 ;
    x[i] <= #1 0;
    y[i] = 0;
  end
  
  initial  
  begin
    error = 0;
    #1 ;
    i = 1;
    #7 ;
    if (x[i] !== 1'b0) 
      begin
        $display("FAILED - x[1] != 0");
        error = 1;
      end
      
    if (y[i] !== 1'b0) 
      begin
        $display("FAILED - y[1] != 0");
        error = 1;
      end
      
    if (error === 0) 
      $display(PASSED);
      
  end
endmodule

