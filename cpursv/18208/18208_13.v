
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w4,w5,w40,w45,w2560,w2515,w10060;

  assign w1 = i_data0;
  assign w10060 = (1+1)*w2515<<<1;
  assign w2515 = w2560-w45;
  assign w2560 = w5*((1+1)**9);
  assign w4 = (1+1)*w1<<1;
  assign w40 = w5*((1+1)**3);
  assign w45 = w5+w40;
  assign w5 = w4+w1;
  assign o_data0 = w10060;
endmodule

