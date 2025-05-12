module nh_sr_unit (
  input clock,
  input reset,
  input [`NH_BITWIDTH+1:0] shift_in,
  output reg [`NH_BITWIDTH+1:0] shift_out
);
always@(posedge clock or negedge reset) begin
  if(reset == 1'b0)
    shift_out <= {1'd0, `NH_WIDTH'd0};
  else
    shift_out <= shift_in;
end 
endmodule