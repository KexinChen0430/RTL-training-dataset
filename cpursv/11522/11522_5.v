
module assert_change_assume(clk,reset_n,start_event,test_expr,window,ignore_new_start,
                            reset_on_new_start,error_on_new_start,xzcheck_enable);

  parameter  width = 8;
  parameter  num_cks = 2;
  input  
      clk               ,
      reset_n           ,
      start_event       ,
      window            ,
      ignore_new_start  ,
      reset_on_new_start,
      error_on_new_start,
      xzcheck_enable    ;
  input  [(0-1)+width:0] test_expr;


endmodule

