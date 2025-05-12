module mu_add (input shortint unsigned a, b, output shortint unsigned sc, ss);
   assign sc = a + b;
   always @(a, b) ss = a + b;
endmodule