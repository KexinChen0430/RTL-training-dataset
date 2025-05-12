
module main();

  reg  [31:0] v1,v2,v3;
  reg  error;
  event event_1,event_2;
  
  always @(event_1)  begin
    v1 = v1+1;
  end
  
  always @(event_2)  begin
    v2 = 1;
  end
  
  initial  
  begin
    error = 0;
    v1 = 0;
    v2 = 0;
    v3 = 0;
    #5 ;
    -> event_1 ;
    v3 = 1;
    #1 ;
    if (v1 !== 1) 
      begin
        $display("FAILED - event3.15 event1 trigger didn't occur");
        error = 1;
      end
      
    #5 -> event_2 ;
    #1 ;
    if (v2 !== 1) 
      begin
        $display("FAILED - event3.15 event2 trigger didn't occur");
        error = 1;
      end
      
    v3 = 2;
    #5 -> event_1 ;
    #1 ;
    if (v1 !== 2) 
      begin
        $display("FAILED - event3.15 event1 trigger didn't occur");
        error = 1;
      end
      
    v3 = 3;
    #5 ;
    if (error === 0) 
      $display(PASSED);
      
  end
endmodule

