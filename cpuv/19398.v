module main; 
reg globvar; 
task my_task; 
  globvar = 1'b1; 
endtask 
initial 
  begin 
    globvar = 1'b0; 
    my_task; 
    if(globvar) 
      $display("PASSED"); 
    else 
      $display("FAILED - task 3.14A task didn't correctly affect global var"); 
  end 
endmodule 