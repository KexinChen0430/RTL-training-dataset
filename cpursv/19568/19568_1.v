
module main();

  reg  clock;
  reg  q;
  reg  reset;
  reg  error;

  
  task task_a;

    begin
      #2 ;
      if (reset) q = 0;
      else q = ~q;
    end
  endtask
  
  initial  
  begin
    error = 0;
    reset = 1;
    task_a;
    #4 ;
    if (q != 1'b0) 
      begin
        $display("FAILED - disable3.6B - Flop didn't clear on clock & reset");
        error = 1;
      end
      
    reset = 1'b0;
    task_a;
    #3 ;
    if (q != 1'b1) 
      begin
        $display("FAILED - disable3.6B - Flop didn't set on clock");
        error = 1;
      end
      
    #3 ;
    
    fork
        task_a;
        begin
          #1 ;
          disable task_a;
        end
    join

    if (q != 1'b1) 
      begin
        $display("FAILED - disable3.6B - Disable task didn't stop toggle");
        error = 1;
      end
      
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

