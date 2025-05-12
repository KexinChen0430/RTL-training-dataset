
module regr(input  clk,
            input  clear,
            input  hold,
            input  wire [(-1)+N:0] in,
            output reg [(-1)+N:0] out);

  parameter  N = 1;

  
  always @(posedge clk)
      begin
        if (clear) out <= {N{1'b0}};
        else if (hold) out <= out;
        else out <= in;
      end
endmodule

