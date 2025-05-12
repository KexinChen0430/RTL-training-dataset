module ms_add (input int signed a, b, output int signed sc, ss);
   assign sc = a + b;
   always @(a, b) ss = a + b;
endmodule