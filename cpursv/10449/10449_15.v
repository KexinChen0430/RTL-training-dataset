
module half_adder(input  x_in,
                  input  y_in,
                  output wire s_out,
                  output wire c_out);

  assign s_out = (((y_in & ~x_in) ^ (~x_in & ((x_in & y_in) ^ x_in))) | ((~y_in | (x_in | y_in)) & x_in)) & (~x_in | ((x_in & y_in) ^ x_in));
  assign c_out = x_in & y_in;
endmodule

