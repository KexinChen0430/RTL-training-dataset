module mu_add (input int unsigned a, b, output int unsigned sc, ss);
   assign sc = a + b;
   always @(a, b) ss = a + b;
endmodule