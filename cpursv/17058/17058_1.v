
module clean_rst(input  clk,
                 input  rsti,
                 output reg rsto);

  reg  rstt;

  
  always @(posedge clk or posedge rsti)
      begin
        rstt <= rsti ? 1'b1 : 1'b0;
        rsto <= rsti ? 1'b1 : rstt;
      end
endmodule

