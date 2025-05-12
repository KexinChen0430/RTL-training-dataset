
module ram_32x32_dp_be(data_a,wren_a,address_a,data_b,address_b,wren_b,byteena_a,
                       clock_a,clock_b,q_a,q_b);

  input  [31:0] data_a;
  input  wren_a;
  input  [4:0] address_a;
  input  [31:0] data_b;
  input  [4:0] address_b;
  input  wren_b;
  input  [3:0] byteena_a;
  input  clock_a;
  input  clock_b;
  output [31:0] q_a;
  output [31:0] q_b;


endmodule

