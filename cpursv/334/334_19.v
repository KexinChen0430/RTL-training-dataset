
module reverse_words  #(parameter  M = 4, WORDS = 1)
  (input  [(WORDS*M)-1:0] in,
   output [(WORDS*M)-1:0] out);

  genvar i;
  for (i = 0; i < WORDS; i = 1+i)
      begin : REV
        assign out[M*i +: M] = in[M*((WORDS-i)+(-1)) +: M];
      end
endmodule

