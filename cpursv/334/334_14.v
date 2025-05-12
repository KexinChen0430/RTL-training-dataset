
module reverse_words  #(parameter  M = 4, WORDS = 1)
  (input  [(-1)+(WORDS*M):0] in,
   output [(-1)+(WORDS*M):0] out);

  genvar i;
  for (i = 0; i < WORDS; i = i+1)
      begin : REV
        assign out[i*M +: M] = in[(WORDS+((-i)+(-1)))*M +: M];
      end
endmodule

