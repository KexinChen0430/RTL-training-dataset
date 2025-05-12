module sub (input [7:0] allbits, input [1:0] onebit, output bitout); 
   `INLINE_MODULE 
     parameter integer P = 0; 
   initial if (P != 1) $stop; 
   assign bitout = (^ onebit) ^ (^ allbits); 
endmodule 