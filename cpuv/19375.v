module a; 
   event FOO; 
   task b; 
      ->FOO; 
   endtask 
   initial @FOO $display("PASSED"); 
   initial #1 b; 
endmodule 