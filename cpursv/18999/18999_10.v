
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w4,w5,w512,w507,w1280,w773,w12368,w11861,w23722;

  assign w1 = i_data0;
  assign w11861 = (-w507)+w12368;
  assign w12368 = ((1+1)**4)*w773;
  assign w1280 = ((1+1)**8)*w5;
  assign w23722 = w11861<<<1;
  assign w4 = w1<<<1+1;
  assign w5 = w4+w1;
  assign w507 = w512-w5;
  assign w512 = ((1+1)**9)*w1;
  assign w773 = (-w507)+w1280;
  assign o_data0 = w23722;
endmodule

