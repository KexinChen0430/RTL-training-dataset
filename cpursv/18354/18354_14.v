
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w512,w511,w4,w507,w4056,w4057,w32456;

  assign w1 = i_data0;
  assign w32456 = w4057*((1+1)**3);
  assign w4 = w1<<1+1;
  assign w4056 = ((1+1)**3)*w507;
  assign w4057 = w4056+w1;
  assign w507 = w511+(0-w4);
  assign w511 = w512+(-w1);
  assign w512 = w1<<<9;
  assign o_data0 = w32456;
endmodule

