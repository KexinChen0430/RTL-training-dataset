
module bit1_bit0_parity1_parity0_ez_instance__state_net(bit1,bit0,parity1,parity0,ez_instance__state);

  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  input  bit0;
  input  bit1;
  output ez_instance__state;
  output parity0;
  output parity1;

  assign ez_instance__state = ~(_04_ | _10_);
  assign _11_ = ~(ez_instance__state | _14_);
  assign _12_ = ~(_05_ | parity1);
  assign _13_ = ~(_00_ | _12_);
  assign _02_ = ~(_13_ | _11_);
  assign parity1 = ~_02_;
  assign _14_ = ~bit1;
  assign _00_ = ~bit0;
  assign _01_ = ~ez_instance__state;
  assign _03_ = ~(_01_ | _14_);
  assign _04_ = ~(_02_ | parity0);
  assign _05_ = ~(_01_ | parity0);
  assign _06_ = ~(_00_ | _05_);
  assign _07_ = ~_06_;
  assign _08_ = ~(_04_ | _07_);
  assign _09_ = ~(_08_ | _03_);
  assign parity0 = ~_09_;
  assign _10_ = ~(parity0 | ez_instance__state);
endmodule

