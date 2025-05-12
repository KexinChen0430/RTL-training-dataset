module within_range
  (input wreal vpass,  
   input wreal gnd,    
   output out);        
   parameter real V_MIN = 0.5;
   parameter real V_MAX = 10;
   wreal in_int = vpass - gnd;
   assign out = (V_MIN <= in_int && in_int <= V_MAX);
endmodule