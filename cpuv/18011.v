module eh2_ram #(depth=4096, width=39) 
   (); 
   `INLINE_MODULE 
   reg [(width-1):0] ram_core [(depth-1):0]; 
endmodule 