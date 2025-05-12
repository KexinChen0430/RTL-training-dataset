module mu_add (input longint unsigned a, b, output longint unsigned sc, ss);
   assign sc = a + b;
   always @(a, b) ss = a + b;
endmodule