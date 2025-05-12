
module t(clk,model);

  input  clk;
  parameter  MODEL_WIDTH = 10;
  input  [MODEL_WIDTH-1:0] model;

  
  initial    $write("Model width = %0d\n",MODEL_WIDTH);
  sub sub(.clk(clk));
endmodule

