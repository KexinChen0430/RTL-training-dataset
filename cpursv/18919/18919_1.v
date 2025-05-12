
module te(input  clk,
          input  vconst,
          input  b,
          output reg q);

  reg  qmid;

  
  always @(posedge vconst or posedge clk)  begin
    qmid <= b;
  end
  
  always @(posedge clk or posedge vconst)  begin
    q <= qmid;
  end
endmodule

