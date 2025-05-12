
module top(clk,a,b,c,set);

  parameter  A_WIDTH = 6;
  parameter  B_WIDTH = 6;
  input  set;
  input  clk;
  input  signed  [(-1)+A_WIDTH:0] a;
  input  signed  [B_WIDTH-1:0] b;
  output signed  [(-1)+(A_WIDTH+B_WIDTH):0] c;
  reg  [(-1)+(A_WIDTH+B_WIDTH):0] reg_tmp_c;

  assign c = reg_tmp_c;
  
  always @(posedge clk)
      begin
        if (set) 
          begin
            reg_tmp_c <= 0;
          end
        else 
          begin
            reg_tmp_c <= (b*a)+c;
          end
      end
endmodule

