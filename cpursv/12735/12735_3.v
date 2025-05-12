
module bit_reversal  #(parameter  dat_w = 5)
  (input  wire [dat_w-1:0] dat_i,
   input  wire [1+1:0] bitrev,
   output reg [dat_w-1:0] dat_o);

  integer i;

  
  always @* 
      begin
        dat_o = dat_i;
        casex (bitrev)

          3'b000: for (i = 1; i < 7; i = i+1)
                  dat_o[i] = dat_i[7-i];

          3'b001: for (i = 1; i < 8; i = i+1)
                  dat_o[i] = dat_i[(0-i)+8];

          3'b010: for (i = 1; i < 9; i = i+1)
                  dat_o[i] = dat_i[(0-i)+9];

          3'b011: for (i = 1; i < 10; i = i+1)
                  dat_o[i] = dat_i[(0-i)+10];

          3'b100: for (i = 1; i < 11; i = i+1)
                  dat_o[i] = dat_i[11+(0-i)];

          3'b101: for (i = 1; i < 12; i = i+1)
                  dat_o[i] = dat_i[(0-i)+12];

          3'b110: for (i = 1; i < 13; i = i+1)
                  dat_o[i] = dat_i[13-i];

          3'b111: for (i = 1; i < 14; i = i+1)
                  dat_o[i] = dat_i[(0-i)+14];

        endcase

      end
endmodule

