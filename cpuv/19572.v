module gate(q, a, b);
   output q;
   input  a, b;
   and #5555 (q, a, b);
endmodule