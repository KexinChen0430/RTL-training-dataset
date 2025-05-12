module main; 
  wire y; 
  reg  a,b; 
  reg  error; 
  assign y = a && (b ? 0 : 1);
  initial 
    begin
       error = 0; 
       #1 ; 
       b = 1; 
       a = 1; 
       #1 ; 
       if(y !== 0)
         begin
           $display("FAILED"); 
           error = 1; 
         end
       #1 ; 
       b = 0; 
       #1 ; 
       if(y !== 1)
         begin
           $display("FAILED"); 
           error = 1; 
         end
       if(error === 0)
         $display("PASSED"); 
    end
endmodule 