module pool_add2(
  input clock, 
  input reset, 
  input [`POOL_OUT_BITWIDTH:0] operand_a, 
  input [`POOL_OUT_BITWIDTH:0] operand_b, 
  output reg[`POOL_OUT_BITWIDTH:0] sum 
);
`ifdef POOL_RESET
  always@(posedge clock or negedge reset) begin
    if(reset == 1'b0) 
      sum <= `POOL_OUT_BITWIDTH'd0; 
    else 
      sum <= operand_a + operand_b; 
  end 
`else 
  always@(posedge clock) begin
    sum <= operand_a + operand_b; 
  end 
`endif 
endmodule 