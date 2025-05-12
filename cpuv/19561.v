module ms_add (input longint signed a, b, output longint signed sc, ss);
   assign sc = a + b;
   always @(a, b) ss = a + b;
endmodule