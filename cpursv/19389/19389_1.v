
module test;

  parameter  p_dly = 0;
  reg  d,a1,a2,b2;
  reg  err;
  reg  clk;
  wire b1,c;

  
  always 
      #5 clk = ~clk; assign #p_dly c = d; assign b1 = c;
  
  always @(c)  b2 = c;
  
  always @(posedge clk)
      begin
        a1 <= b1;
        a2 <= b2;
      end
  
  always @(negedge clk)  if (a1 != a2) err = 1;
    
  
  initial  
  begin
    err = 0;
    clk = 0;
    d = 0;
    #20 ;
    @(posedge clk)  d <= 1;
    #25 ;
    if (err == 1) 
      $display(FAILED);
    else 
      $display(PASSED);
    $finish;
  end
endmodule

