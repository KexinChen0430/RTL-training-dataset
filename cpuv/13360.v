module twice for better checking 
   if2 foo 
   ); 
   logic l1, l2; 
   always_ff @(posedge clk) begin 
      if (modnum==1) begin 
         if (foo.i1.var1 != 1) $stop; 
         if (foo.var2 != 2) $stop; 
      end
      if (modnum==2) begin 
         if (foo.i1.var1 != 1) $stop; 
         if (foo.var2 != 2) $stop; 
      end
   end
endmodule 