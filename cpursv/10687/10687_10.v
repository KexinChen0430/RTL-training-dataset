
module altsyncram(clock0,clock1,address_a,data_a,rden_a,wren_a,byteena_a,q_a,
                  addressstall_a,address_b,data_b,rden_b,wren_b,byteena_b,q_b,
                  addressstall_b,clocken0,clocken1,clocken2,clocken3,aclr0,
                  aclr1,eccstatus);

  parameter  lpm_type = altsyncram;
  parameter  operation_mode = dual_port;
  parameter  ram_block_type = auto;
  parameter  intended_device_family = auto;
  parameter  power_up_uninitialized = false;
  parameter  read_during_write_mode_mixed_ports = dontcare;
  parameter  byte_size = 8;
  parameter  widthad_a = 1;
  parameter  width_a = 1;
  parameter  width_byteena_a = 1;
  parameter  numwords_a = 1;
  parameter  clock_enable_input_a = clocken0;
  parameter  widthad_b = 1;
  parameter  width_b = 1;
  parameter  numwords_b = 1;
  parameter  address_aclr_b = aclr0;
  parameter  address_reg_b = "";
  parameter  outdata_aclr_b = aclr0;
  parameter  outdata_reg_b = "";
  parameter  clock_enable_input_b = clocken0;
  parameter  clock_enable_output_b = clocken0;
  input  clock0,clock1;
  input  [(-1)+widthad_a:0] address_a;
  input  [width_a-1:0] data_a;
  input  rden_a;
  input  wren_a;
  input  [(width_a/8)-1:0] byteena_a;
  input  addressstall_a;
  output [width_a-1:0] q_a;
  input  wren_b;
  input  rden_b;
  input  [widthad_b+(-1):0] address_b;
  input  [(-1)+width_b:0] data_b;
  input  [(width_b/8)-1:0] byteena_b;
  input  addressstall_b;
  output [(-1)+width_b:0] q_b;
  input  clocken0;
  input  clocken1;
  input  clocken2;
  input  clocken3;
  input  aclr0;
  input  aclr1;
  output eccstatus;


endmodule

