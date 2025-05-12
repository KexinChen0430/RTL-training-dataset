module mult_adder_mult(
  input clock, 
  input reset, 
  input signed [`CONV_MULT_BITWIDTH:0] operand_a, 
  input signed [`CONV_MULT_BITWIDTH:0] operand_b, 
  output [`CONV_PRODUCT_BITWIDTH:0] out 
);
   reg signed[`CONV_PRODUCT_BITWIDTH:0] product; 
   assign out = product[`CONV_PRODUCT_BITWIDTH:0]; 
   always@(posedge clock or negedge reset) begin
      if(reset == 1'b0) 
	      product <= `CONV_PRODUCT_WIDTH'd0; 
      else 
	      product <= operand_a * operand_b; 
   end 
endmodule 