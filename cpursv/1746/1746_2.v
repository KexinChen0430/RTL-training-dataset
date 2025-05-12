
module adder(input  [39:0] a,
             input  [39:0] b,
             input  add_sub,
             input  adder_en,
             output [39:0] sum);

  assign sum = (add_sub == 1'b1) ? ((0-a)+b) : 
               (add_sub == 1'b0) ? (b+a) : sum;
endmodule

