
module reverse_words  #(parameter  M = 4, WORDS = 1)
  (input  [(M*WORDS)+(-1):0] in,
   output [(M*WORDS)+(-1):0] out);

  genvar i;
  for (i = 0; i < WORDS; i = i+1)
      begin : REV
        assign out[M*i +: M] = in[((0-i)+((-1)+WORDS))*M +: M];
      end
endmodule

