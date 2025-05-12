module sub (input En_t a, output En_t z);
   always @* z = (a==EN_ONE) ? EN_ZERO : EN_ONE;
endmodule