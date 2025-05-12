
module main();

  reg  working;
  reg  clock;

  
  initial  
  begin
    working = 0;
    clock = 0;
    #4 ;
    working = 0;
    #1 ;
    clock = 1;
    #4 ;
    working = 0;
    #1 ;
    clock = 0;
    #5 ;
  end
  
  always   #2 working = 1;
  
  initial  
  begin
    #3 ;
    if (!working) 
      begin
        $display("FAILED - delayed always\n");
        $finish;
      end
      
    #3 ;
    if (!working) 
      begin
        $display("FAILED - posedge always\n");
        $finish;
      end
      
    #7 ;
    if (!working) 
      begin
        $display("FAILED - posedge always\n");
        $finish;
      end
      
    $display(PASSED\n);
    $finish;
  end
  
  always @(posedge clock)  working = 1;
  
  always @(negedge clock)  working = 1;
endmodule

