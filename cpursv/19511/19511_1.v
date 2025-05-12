
module main();

  reg  working;
  reg  timer;

  
  initial  
  begin : my_block
    working = 1;
    #5 ;
    working = 1;
    #5 ;
    working = 1;
    #5 ;
    working = 0;
    #5 ;
  end
  
  initial  
  begin
    #15 ;
    disable my_block;
  end
  
  initial  
  begin
    #20 ;
    if (!working) 
      $display(FAILED);
    else 
      $display(PASSED);
  end
endmodule

