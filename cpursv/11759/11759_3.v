
module dff(clk,rst,inp,outp);

  parameter  WIDTH = 1;
  input  wire clk;
  input  wire rst;
  input  wire [(0-1)+WIDTH:0] inp;
  output reg [(0-1)+WIDTH:0] outp;

  
  always @(posedge clk)
      begin
        outp <= rst ? 0 : inp;
      end
endmodule

