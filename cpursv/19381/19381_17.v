
module main;

  reg  err;
  reg  clk;
  reg  out1,out2;
  realtime  time1;
  realtime  time2;
  real  eps;

  
  always @(posedge clk)
      #2.4 begin
        $display($time,,$realtime," set out1 == 1");
        time1 = $realtime;
        out1 = 1;
      end
  
  always @(posedge clk)
      #2.6 begin
        $display($time,,$realtime," set out2 == 1");
        time2 = $realtime;
        out2 = 1;
      end
  
  initial  
  begin
    clk = 0;
    out1 = 0;
    out2 = 0;
    time1 = 0;
    time2 = 0;
    err = 0;
    $timeformat(-3,1,ms,5);
    #1 
      if (out1 !== 0) 
        begin
          $display("Error -- out1 s/b 0 at time $time but is=%x",out1);
          err = 1;
        end
        

    clk = 1;
    #3 
      if (out1 !== 1) 
        begin
          $display("Error -- out1 s/b 1 at time $time but is=%x",out1);
          err = 1;
        end
        

    eps = time1+(0-3.4);
    if (eps < 0.) eps = 0.-eps;
      
    if (eps > 0.0001) 
      begin
        $display("Error -- time1 s/b 3.4 but is=%t",time1);
        err = 1;
      end
      
    #1 eps = time2-3.6;
    if (eps < 0.) eps = 0.-eps;
      
    if (eps > 0.0001) 
      begin
        $display("Error -- time2 s/b 3.6 but is=%t, ",time2);
        err = 1;
      end
      
    if (err == 0) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

