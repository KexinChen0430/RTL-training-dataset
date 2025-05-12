
module test;

  reg  set;
  parameter  d = 1.55;
  reg  fail;
  reg  [7:0] ii;

  
  initial  
  begin
    fail = 0;
    #d set = 0;
    if ((ii < 15) || (ii > 16)) fail = 1;
      
    #d set = 1;
    if ((ii > 32) || (ii < 31)) fail = 1;
      
  end
  
  initial  
  begin
    for (ii = 0; ii < 50; ii = ii+1)
        begin
          #0.1 ;
        end
    $display(\n\t\t**********************************************);
    if (fail) 
      $display("\t\t********** timescale test FAILED *************");
    else 
      $display("\t\t********** timescale test PASSED *************");
    $display(\t\t**********************************************\n);
    $finish;
  end
endmodule

