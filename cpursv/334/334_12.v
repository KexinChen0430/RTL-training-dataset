
module reverse_words  #(parameter  M = 4, WORDS = 1)
  (input  [(0-1)+(WORDS*M):0] in,
   output [(0-1)+(WORDS*M):0] out);

  genvar i;
  for (i = 0; i < WORDS; i = 1+i)
      begin : REV
        assign out[i*M +: M] = in[(((-i)+WORDS)-1)*M +: M];
      end
endmodule

