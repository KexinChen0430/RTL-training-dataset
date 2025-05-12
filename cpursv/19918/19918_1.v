
module dffsr2_sub(clk,preset,clear,d,q);

  input  clk,preset,clear,d;
  output reg q;

  
  always @(posedge clk or posedge preset or posedge clear)
      begin
        if (preset) q <= 1;
        else if (clear) q <= 0;
        else q <= d;
      end
endmodule

