
module sixteen_bit_byteenable_FSM(write_in,byteenable_in,waitrequest_out,byteenable_out,
                                  waitrequest_in);

  input  write_in;
  input  [1:0] byteenable_in;
  output wire waitrequest_out;
  output wire [1:0] byteenable_out;
  input  waitrequest_in;

  assign byteenable_out = {2{write_in}} & byteenable_in;
  assign waitrequest_out = (waitrequest_in == 1) & (write_in == 1);
endmodule

