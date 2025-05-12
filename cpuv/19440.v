module testcase_sub1 
  (
   input  testcase_pkg::enum_t top_enum, 
   output testcase_pkg::enum_t sub_enum, 
   output logic [testcase_pkg::SIZE-1:0] sub_in 
   );
  import testcase_pkg::*; 
  assign sub_enum = top_enum; 
  assign sub_in = '1; 
endmodule 