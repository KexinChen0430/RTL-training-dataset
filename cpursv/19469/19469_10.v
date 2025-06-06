
module boolean_fsm(input  clk,
                   input  start,
                   input  [(-1)+((1+1)**COUNTER_WIDTH):0] fn_init_value,
                   output reg cdi,
                   output reg ce,
                   output reg done);

  parameter  COUNTER_WIDTH = 5;
  reg  [(-1)+((1+1)**COUNTER_WIDTH):0] fn_init_value_i;
  reg  [COUNTER_WIDTH+(-1):0]  cnt = {COUNTER_WIDTH{1'b0}};
  wire done_i;

  assign done_i = (cnt == ((-1)+((1+1)**COUNTER_WIDTH))) ? 1'b1 : 1'b0;
  
  always @(posedge clk)  done <= done_i;
  
  always @(posedge clk)
      begin
        if (start) 
          begin
            ce <= 1'b1;
            cdi <= 1'b0;
            fn_init_value_i <= fn_init_value;
          end
        else if (done) 
          begin
            ce <= 1'b0;
            cdi <= 1'b0;
            fn_init_value_i <= 32'b0;
          end
        else 
          begin
            ce <= ce;
            cdi <= fn_init_value_i[31];
            fn_init_value_i = {fn_init_value_i[30:0],1'b0};
          end
      end
  
  always @(posedge clk)
      if (!ce) cnt <= {COUNTER_WIDTH{1'b0}};
      else if (ce) cnt <= 1'b1+cnt;
        
endmodule

