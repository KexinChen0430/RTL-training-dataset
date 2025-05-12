
module nonblocking_gate(clk,ctrl,din,sel,dout);

  input  clk;
  input  [4:0] ctrl;
  input  [1:0] din;
  input  sel;
  output reg [31:0] dout;

  
  always @(posedge clk)
      begin
        dout <= dout+1;
        case ({sel*ctrl})

          0: dout[31:0] <= din;

          1: dout[31:1] <= din;

          2: dout[31:2] <= din;

          3: dout[31:3] <= din;

          31: dout[31:31] <= din;

        endcase

      end
endmodule

