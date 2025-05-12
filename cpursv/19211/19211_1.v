
module main();

  reg  flag1;
  reg  event_1;

  
  always @(posedge event_1)  flag1 = ~flag1;
  
  initial  
  begin
    event_1 = 1'b0;
    #1 flag1 = 0;
    #1 event_1 = 1'b1;
    #1 
      if (flag1 !== 1'b1) 
        begin
          $display("FAILED -- 0->1 didn't trigger flag1");
          $finish;
        end
        

    event_1 = 1'b0;
    #1 
      if (flag1 !== 1'b1) 
        begin
          $display("FAILED -- 1->0 DID trigger flag1");
          $finish;
        end
        

    $display(PASSED);
  end
endmodule

