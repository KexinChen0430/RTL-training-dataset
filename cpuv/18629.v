module jobs (out); 
   output out;     
   reg    out;     
   task set;
      input val;   
      begin
         #1 out = val; 
      end
   endtask : set 
endmodule 