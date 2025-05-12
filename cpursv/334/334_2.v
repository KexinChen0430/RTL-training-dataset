
module reverse_words  #(parameter  M = 4, WORDS = 1)
  (input  [(M*WORDS)+(-1):0] in,
   output [(M*WORDS)+(-1):0] out);

  genvar i;
  for (i = 0; i < WORDS; i = 1+i)
      begin : REV
        assign out[i*M +: M] = in[M*((WORDS+(-1))+(-i)) +: M];
      end
endmodule

