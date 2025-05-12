
module reset_test_gate(clk,reset,ctrl,din,sel,dout);

  input  wire clk;
  input  wire reset;
  input  wire [4:0] ctrl;
  input  wire [1:0] din;
  input  wire sel;
  output reg [31:0] dout;
  reg  [1:0] i;
  wire rval;

  assign rval = {reset,1'b0};
  
  always @(posedge clk)
      begin
        case (|reset)

          1'b1: begin
                case ({0})

                  0: dout[31:0] <= 57005;

                  31: dout[31:31] <= 57005;

                endcase

                i = 1;
              end

        endcase

        case ({sel*ctrl})

          0: dout[31:0] <= din;

          31: dout[31:31] <= din;

        endcase

      end
endmodule

