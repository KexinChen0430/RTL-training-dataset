module ifdef1; 
reg error ; 
`ifdef NOCODE
initial 
   begin
     #20; 
     error = 1; 
     #20; 
   end
`endif 
initial 
 begin
   #1; 
   error = 0; 
   #40; 
   if(error == 0) 
      $display("PASSED"); 
   else
      $display("FAILED"); 
  end
endmodule 