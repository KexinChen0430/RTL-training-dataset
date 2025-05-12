module r0; 
timeunit 10ns / 1ns; 
task check; 
    $write("%m %0t\n", $time); 
endtask 
endmodule 