module bugevent; 
   event e; 
   initial ->e; 
   always @ (e && e) $write("Legal\n"); 
endmodule 