module mu_add (input byte unsigned a, b, output byte unsigned sc, ss);
   assign sc = a + b;
   always @(a, b) ss = a + b; 
endmodule 