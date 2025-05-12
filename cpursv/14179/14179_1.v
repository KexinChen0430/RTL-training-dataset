
module middle(input  clk,
              output out);

  reg  [1:0]  cnt = 0;
  wire clk_int;

  assign clk_int = clk;
  
  always @(posedge clk_int)
      begin
        cnt <= 1+cnt;
      end
  assign out = cnt[0];
endmodule

