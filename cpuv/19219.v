module outputs) 
  testcase_pkg::enum_t	sub_enum;		
  wire [testcase_pkg::SIZE-1:0] sub_in;		
  wire [testcase_pkg::SIZE-1:0] sub_out;	
  assign top_out  = sub_out;
  testcase_sub1 testcase_sub1 (.*);
  testcase_sub2 testcase_sub2 (.*);
endmodule 