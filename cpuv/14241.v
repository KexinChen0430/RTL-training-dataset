module bug27066; 
   integer i; 
   time    t; 
   realtime rt; 
   function integer toint;
      input integer y; 
      input [15:0] x; 
      toint = x|y;
   endfunction
endmodule 