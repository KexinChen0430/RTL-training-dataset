
module dff(clk,rst,inp,outp);

  parameter  WIDTH = 1;
  input  wire clk;
  input  wire rst;
  input  wire [WIDTH+(0-1):0] inp;
  output reg [WIDTH+(0-1):0] outp;

  
  always @(posedge clk)
      begin
        outp <= rst ? 0 : inp;
      end
endmodule

