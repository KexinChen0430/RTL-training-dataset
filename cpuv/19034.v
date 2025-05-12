module stim; 
   wire [1:0] data; 
   wire       result; 
   assign result = data ? 1:0; 
   initial 
       $display("PASSED"); 
endmodule 