module norm_add2(
  input clock,                          
  input reset,                          
  input [`NORM_OUT_BITWIDTH:0] operand_a, 
  input [`NORM_OUT_BITWIDTH:0] operand_b, 
  output reg[`NORM_OUT_BITWIDTH:0] sum 
);
`ifdef NORM_RESET
always@(posedge clock or negedge reset) begin
  if(reset == 1'b0)                     
    sum <= `NORM_OUT_WIDTH'd0;          
  else                                  
    sum <= operand_a + operand_b;       
end 
`else
always@(posedge clock) begin
  sum <= operand_a + operand_b;         
end 
`endif
endmodule 