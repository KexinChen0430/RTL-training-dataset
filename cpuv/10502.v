module Test (
     input  pack_t in,    
     output pack_t out);  
   always @* begin
      out = in;          
      out.b1 = in.b1 + 1; 
      out.b0 = 1'b1;     
   end
endmodule