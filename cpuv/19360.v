module m2 #( integer PAR2 = 10); 
   initial begin
      $display("%x",PAR2); 
      if (PAR2 !== 2) $stop; 
   end 
endmodule 