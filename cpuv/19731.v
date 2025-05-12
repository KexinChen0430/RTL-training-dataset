module test; 
reg a,b,c; 
reg error; 
initial 
  begin
    error = 0; 
    fork 
      a = 1; 
      b = 0; 
      c = 1; 
    join 
  if(a !== 1) 
     begin
       $display("FAILED - a not set to 1"); 
       error = 1; 
     end
  if(b !== 0) 
     begin
       $display("FAILED - b not set to 0"); 
       error = 1; 
     end
  if(c !== 1) 
     begin
       $display("FAILED - c not set to 1"); 
       error = 1; 
     end
  if(error == 0) 
    $display("PASSED"); 
  end
endmodule 