module t; 
   timeunit 1ns; 
   timeprecision 1ps; 
   time t; 
   initial begin 
      t = 10ns; 
      $write("[%0t] In %m: Hi\n", $time); 
      $printtimescale; 
      $printtimescale(); 
      $printtimescale(t); 
      $write("Time: '%t' 10ns=%0t\n", $time, t); 
      $timeformat(-3, 0, "-my-ms", 8); 
      $write("Time: '%t' 10ns=%0t\n", $time, t); 
      $timeformat(-3, 1, "-my-ms", 10); 
      $write("Time: '%t' 10ns=%0t\n", $time, t); 
      $timeformat(-6, 2, "-my-us", 12); 
      $write("Time: '%t' 10ns=%0t\n", $time, t); 
      $timeformat(-9, 3, "-my-ns", 13); 
      $write("Time: '%t' 10ns=%0t\n", $time, t); 
      $timeformat(-12, 3, "-my-ps", 13); 
      $write("Time: '%t' 10ns=%0t\n", $time, t); 
      $timeformat(-15, 4, "-my-fs", 14); 
      $write("Time: '%t' 10ns=%0t\n", $time, t); 
      $write("*-* All Finished *-*\n"); 
      $finish; 
   end 
endmodule 