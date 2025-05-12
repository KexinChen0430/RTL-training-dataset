module testcase_sub2
  (
   input                                 testcase_pkg::enum_t sub_enum, 
   input logic [testcase_pkg::SIZE-1:0]  sub_in, 
   output logic [testcase_pkg::SIZE-1:0] sub_out 
   );
   import testcase_pkg::*;
   assign sub_out  = (sub_enum==ENUM1) ? ~sub_in : sub_in;
endmodule