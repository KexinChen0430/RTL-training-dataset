module mult_adder_add(
  input clock,
  input reset,
  input [`CONV_ADD_BITWIDTH:0] operand_a,
  input [`CONV_ADD_BITWIDTH:0] operand_b,
  input c_a, 
  input c_b,
  output [`CONV_ADD_BITWIDTH:0] out,
  output carry
);
   reg [`CONV_ADD_BITWIDTH+1:0]    sum;
   assign out = sum[`CONV_ADD_BITWIDTH:0];
   assign carry = sum[`CONV_ADD_BITWIDTH + 1] | c_a | c_b;
   always@(posedge clock or negedge reset) begin
      if(reset == 1'b0)
	      sum <= {1'b0,`CONV_ADD_WIDTH'd0};
      else
	      sum <= operand_a + operand_b;
   end 
   endmodule