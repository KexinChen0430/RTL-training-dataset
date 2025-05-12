module InstModule (o,i);
   parameter WIDTH;
   input [WIDTH-1:0] i;
   parameter type OUT_t;
   output OUT_t o;
endmodule