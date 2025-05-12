
module weird_ff(p_clk,rst_in,reg_req_t,out);

  input  p_clk;
  input  rst_in;
  input  reg_req_t;
  output out;
  reg  [1:0] wr_req_pipe;
  parameter  G_ASYNC_RESET = 0;
  wire  a_rst = (G_ASYNC_RESET != 0) ? rst_in : 1'b0;
  wire  s_rst = (G_ASYNC_RESET == 0) ? rst_in : 1'b0;

  
  always @(posedge p_clk or posedge a_rst)
      if (s_rst | a_rst) wr_req_pipe <= 'b0;
      else wr_req_pipe <= {wr_req_pipe,reg_req_t};
  assign out = wr_req_pipe[1];
endmodule

