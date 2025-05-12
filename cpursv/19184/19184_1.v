
module main;

  reg  clk;
  reg  out1,out2;
  time  time1;
  time  time2;

  
  always @(posedge clk)
      #2.4 begin
        $display($time,,"set out1 == 1");
        time1 = $time;
        out1 = 1;
      end
  
  always @(posedge clk)
      #2.6 begin
        $display($time,,"set out2 == 1");
        time2 = $time;
        out2 = 1;
      end
  
  initial  
  begin
    clk = 0;
    out1 = 0;
    out2 = 0;
    time1 = 0;
    time2 = 0;
    #1 
      if (out1 !== 0) 
        begin
          $display("FAILED -- out1 is not 0: %b",out1);
          $finish;
        end
        

    clk = 1;
    #3 
      if (out1 !== 1) 
        begin
          $display("FAILED -- out is not 1 at time 3: %b",out1);
          $finish;
        end
        

    if (time1 != 3) 
      begin
        $display("FAILED -- time1 = %d",time1);
        $finish;
      end
      
    #1 
      if (time2 != 4) 
        begin
          $display("FAILED -- time2 = %d",time2);
          $finish;
        end
        

    $display(PASSED);
  end
endmodule

