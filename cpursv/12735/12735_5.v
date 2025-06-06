
module bit_reversal  #(parameter  dat_w = 5)
  (input  wire [(0-1)+dat_w:0] dat_i,
   input  wire [1<<<1:0] bitrev,
   output reg [(0-1)+dat_w:0] dat_o);

  integer i;

  
  always @* 
      begin
        dat_o = dat_i;
        casex (bitrev)

          3'b000: for (i = 1; i < 7; i = i+1)
                  dat_o[i] = dat_i[(-i)+7];

          3'b001: for (i = 1; i < 8; i = i+1)
                  dat_o[i] = dat_i[8+(-i)];

          3'b010: for (i = 1; i < 9; i = i+1)
                  dat_o[i] = dat_i[(-i)+9];

          3'b011: for (i = 1; i < 10; i = i+1)
                  dat_o[i] = dat_i[10+(-i)];

          3'b100: for (i = 1; i < 11; i = i+1)
                  dat_o[i] = dat_i[11-i];

          3'b101: for (i = 1; i < 12; i = i+1)
                  dat_o[i] = dat_i[12+(-i)];

          3'b110: for (i = 1; i < 13; i = i+1)
                  dat_o[i] = dat_i[13-i];

          3'b111: for (i = 1; i < 14; i = i+1)
                  dat_o[i] = dat_i[14-i];

        endcase

      end
endmodule

