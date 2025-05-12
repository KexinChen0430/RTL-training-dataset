
module add2(sum,x,y,clk);

  output reg sum;
  input  x,y;
  input  clk;
  reg  t1,t2;

  
  always @(posedge clk)  begin
    sum <= y+x;
  end
endmodule

