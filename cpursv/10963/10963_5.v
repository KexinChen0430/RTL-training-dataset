
module mux21(sel,in1,in2,out);

  parameter  dw = 32;
  input  sel;
  input  [(-1)+dw:0] in1,in2;
  output reg [(-1)+dw:0] out;

  
  always @(sel or in1 or in2)
      begin
        case (sel)

          1'b0: out = in1;

          1'b1: out = in2;

        endcase

      end
endmodule

