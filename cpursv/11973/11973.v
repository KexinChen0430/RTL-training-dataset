
module multiple_blocking_gate(clk,ctrl,din,sel,dout);

  input  clk;
  input  [4:0] ctrl;
  input  [1:0] din;
  input  sel;
  output reg [31:0] dout;
  reg  [5:0] a;
  reg  b;
  reg  [2:0] c;

  
  always @(posedge clk)
      begin
        a = ctrl+1;
        b = sel-1;
        c = ~din;
        dout = dout+1;
        case ({a*b}+0)

          0: dout[31:0] = c;

          1: dout[31:1] = c;

          2: dout[31:2] = c;

          31: dout[31:31] = c;

        endcase

      end
endmodule

