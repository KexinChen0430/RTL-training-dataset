
module assert_quiescent_state_assume(clk,reset_n,state_expr,check_value,sample_event,
                                     end_of_simulation,xzcheck_enable);

  parameter  width = 8;
  input  clk,reset_n,sample_event;
  input  [(0-1)+width:0] state_expr,check_value;
  input  end_of_simulation;
  input  xzcheck_enable;


endmodule

