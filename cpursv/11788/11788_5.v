
module sm_debouncer  #(parameter  SIZE = 1)
  (input  clk,
   input  [(-1)+SIZE:0] d,
   output reg [(-1)+SIZE:0] q);

  reg  [(-1)+SIZE:0] data;

  
  always @(posedge clk)
      begin
        data <= d;
        q <= data;
      end
endmodule

