
module bit_reversal  #(parameter  dat_w = 5)
  (input  wire [(-1)+dat_w:0] dat_i,
   input  wire [2:0] bitrev,
   output reg [(-1)+dat_w:0] dat_o);

  integer i;

  
  always @* 
      begin
        dat_o = dat_i;
        casex (bitrev)

          3'b000: for (i = 1; i < 7; i = 1+i)
                  dat_o[i] = dat_i[7+(0-i)];

          3'b001: for (i = 1; i < 8; i = 1+i)
                  dat_o[i] = dat_i[8-i];

          3'b010: for (i = 1; i < 9; i = 1+i)
                  dat_o[i] = dat_i[9+(0-i)];

          3'b011: for (i = 1; i < 10; i = 1+i)
                  dat_o[i] = dat_i[10+(0-i)];

          3'b100: for (i = 1; i < 11; i = 1+i)
                  dat_o[i] = dat_i[(0-i)+11];

          3'b101: for (i = 1; i < 12; i = 1+i)
                  dat_o[i] = dat_i[12+(0-i)];

          3'b110: for (i = 1; i < 13; i = 1+i)
                  dat_o[i] = dat_i[13+(0-i)];

          3'b111: for (i = 1; i < 14; i = 1+i)
                  dat_o[i] = dat_i[14+(0-i)];

        endcase

      end
endmodule

