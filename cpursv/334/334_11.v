
module reverse_words  #(parameter  M = 4, WORDS = 1)
  (input  [(-1)+(M*WORDS):0] in,
   output [(-1)+(M*WORDS):0] out);

  genvar i;
  for (i = 0; i < WORDS; i = 1+i)
      begin : REV
        assign out[M*i +: M] = in[(((-1)+(0-i))+WORDS)*M +: M];
      end
endmodule

