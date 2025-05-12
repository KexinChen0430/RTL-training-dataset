module modname; 
  time t; 
  task check;
    t = 1ns; 
    $write("%m %0t\n", t);
  endtask 
endmodule 