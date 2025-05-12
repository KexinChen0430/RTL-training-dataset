module r1;
   timeunit 10ns;
   timeprecision 1ns;
   task check; $write("%m %0t\n", $time); endtask
endmodule