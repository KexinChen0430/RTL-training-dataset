
module gen_test4(a,b);

  input  [3:0] a;
  output [3:0] b;

  genvar i;
  
  generate
      for (i = 0; i < 3; i = 1+i)
          begin : foo
            localparam  PREV = i+(0-1);

            wire temp;

            if (i == 0) assign temp = a[0];
            else assign temp = a[i] & foo[PREV].temp;
            assign b[i] = temp;
          end
  endgenerate

endmodule

