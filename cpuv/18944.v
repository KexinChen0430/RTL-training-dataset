module define1 ; 
reg [`WIDTH-1:0] val ; 
reg error; 
initial 
  begin 
     error = 0; 
     val = `NUM1 ; 
     if(val !== 10) 
       begin 
         error = 1; 
         $display("FAILED - define NUM1 10 didn't"); 
       end 
     val = `NUM2 ; 
     if(val !== 4'h1) 
       begin 
         error = 1; 
         $display("FAILED - define NUM1 10 didn't"); 
       end 
     val = `NUM3 ; 
     if(val !== 4'b0100) 
       begin 
         error = 1; 
         $display("FAILED - define NUM1 10 didn't"); 
       end 
     if(error == 0) 
       $display("PASSED"); 
  end 
endmodule 