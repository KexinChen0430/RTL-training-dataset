
module regr(clk,rst,clear,hold,in,out);

  parameter  N = 1;
  input  clk;
  input  rst;
  input  clear;
  input  hold;
  input  wire [(0-1)+N:0] in;
  output reg [(0-1)+N:0] out;

  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            out <= {N{1'b0}};
          end
        else if (clear) 
          begin
            out <= {N{1'b0}};
          end
        else if (hold) 
          begin
            out <= out;
          end
        else 
          begin
            out <= in;
          end
      end
endmodule

