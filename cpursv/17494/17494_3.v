
module ParityGen(In,Out);

  parameter  Parity = 0, Width = 8;
  input  [(-1)+Width:0] In;
  output reg Out;

  
  always @(In)
      begin
        case (Parity)

          1: Out = ~^In;

          1<<1: Out = ^In;

          3: Out = 1;

          4: Out = 0;

          default: Out = 1'b0;

        endcase

      end
endmodule

