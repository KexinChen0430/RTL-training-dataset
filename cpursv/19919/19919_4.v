
module top(clk,a,b,c,set);

  parameter  A_WIDTH = 6;
  parameter  B_WIDTH = 6;
  input  set;
  input  clk;
  input  signed  [A_WIDTH+(0-1):0] a;
  input  signed  [(0-1)+B_WIDTH:0] b;
  output signed  [B_WIDTH+(A_WIDTH+(0-1)):0] c;
  reg  [B_WIDTH+(A_WIDTH+(0-1)):0] reg_tmp_c;

  assign c = reg_tmp_c;
  
  always @(posedge clk)
      begin
        if (set) 
          begin
            reg_tmp_c <= 0;
          end
        else 
          begin
            reg_tmp_c <= (a*b)+c;
          end
      end
endmodule

