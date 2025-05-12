module sub (
   o,
   i
   );
   input                 rel_t [1:0] i;
   output                rel_t [1:0] o;
   assign o = i;
endmodule