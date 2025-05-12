
module reverse_words  #(parameter  M = 4, WORDS = 1)
  (input  [(M*WORDS)-1:0] in,
   output [(M*WORDS)-1:0] out);

  genvar i;
  for (i = 0; i < WORDS; i = 1+i)
      begin : REV
        assign out[M*i +: M] = in[M*(((-1)+WORDS)+(-i)) +: M];
      end
endmodule

