
module main();

  reg  flag1,flag2,flag12;
  event event_1,event_2;
  
  always @(event_1)  flag1 = ~flag1;
  
  always @(event_2)  flag2 = ~flag2;
  
  always @(event_1 or event_2)  flag12 = ~flag12;
  
  initial  
  begin
    flag1 = 0;
    flag2 = 0;
    flag12 = 0;
    #1 -> event_1 ;
    #1 
      if (flag1 !== 1) 
        begin
          $display("FAILED -- event_1 didn't trigger flag1");
          $finish;
        end
        

    if (flag2 !== 0) 
      begin
        $display("FAILED -- event_1 DID trigger flag2");
        $finish;
      end
      
    if (flag12 !== 1) 
      begin
        $display("FAILED -- event_1 didn't trigger flag12");
        $finish;
      end
      
    flag1 = 0;
    flag2 = 0;
    flag12 = 0;
    #1 -> event_2 ;
    #1 
      if (flag1 !== 0) 
        begin
          $display("FAILED -- event_2 DID trigger flag1");
          $finish;
        end
        

    if (flag2 !== 1) 
      begin
        $display("FAILED -- event_2 didn't trigger flag2");
        $finish;
      end
      
    if (flag12 !== 1) 
      begin
        $display("FAILED -- event_1 didn't trigger flag12");
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

