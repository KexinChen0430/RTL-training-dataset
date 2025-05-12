
module main;

  reg  [7:0]  delay = 0;
  reg  step;

  
  initial  
  begin
    delay = 2;
    step = 0;
    step <= #(delay) 1;
    #1 
      if (step !== 0) 
        begin
          $display("FAILED -- step=%b at time=1",step);
          $finish;
        end
        

    #2 
      if (step !== 1) 
        begin
          $display("FAILED == step=%b at time=3",step);
          $finish;
        end
        

    $display(PASSED);
  end
endmodule

