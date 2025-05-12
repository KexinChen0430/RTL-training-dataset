
module sirv_gnrl_dffrs  #(parameter  DW = 32)
  (input  [(-1)+DW:0] dnxt,
   output [(-1)+DW:0] qout,
   input  clk,
   input  rst_n);

  reg  [(-1)+DW:0] qout_r;

  
  always @(posedge clk or negedge rst_n)
      begin : DFFRS_PROC
        if (rst_n == 1'b0) qout_r <= {DW{1'b1}};
        else qout_r <= #1 dnxt;
      end
  assign qout = qout_r;
endmodule

