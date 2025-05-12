
module nonblocking_gate(clk,ctrl,din,sel,dout);

  input  wire clk;
  input  wire [4:0] ctrl;
  input  wire [1:0] din;
  input  wire sel;
  output reg [31:0] dout;

  
  always @(posedge clk)
      begin
        dout <= dout+1;
        case ({sel*ctrl})

          0: dout[31:0] <= din;

          1: dout[31:1] <= din;

          1+1: dout[31:1+1] <= din;

          31: dout[31:31] <= din;

        endcase

      end
endmodule

