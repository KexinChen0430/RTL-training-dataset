module t (); 
class Cls; 
   int imembera; 
   int imemberb; 
   typedef enum { ENUM_VAL = 22 } enum_t; 
endclass : Cls 
   Cls c; 
   Cls d; 
   Cls::enum_t e; 
   initial begin 
      c = new; 
      d = new; 
      e = Cls::ENUM_VAL; 
      c.imembera = 10; 
      d.imembera = 11; 
      c.imemberb = 20; 
      d.imemberb = 21; 
      if (c.imembera != 10) $stop; 
      if (d.imembera != 11) $stop; 
      if (c.imemberb != 20) $stop; 
      if (d.imemberb != 21) $stop; 
      if (Pkg::ENUMP_VAL != 33) $stop; 
      if (Cls::ENUM_VAL != 22) $stop; 
      if (c.ENUM_VAL != 22) $stop; 
      if (e != Cls::ENUM_VAL) $stop; 
      if (e != 22) $stop; 
      $write("*-* All Finished *-*\n"); 
      $finish; 
   end 
endmodule 