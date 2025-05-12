module global_mod; 
   `INLINE_MODULE 
   parameter INITVAL = 0; 
   integer globali; 
   initial globali = INITVAL; 
   function [31:0] getName;
      input fake; 
      getName = "gmod"; 
   endfunction
   function [31:0] getGlob;
      input fake; 
      getGlob = globali; 
   endfunction
endmodule 