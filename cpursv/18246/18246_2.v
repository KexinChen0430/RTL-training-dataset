
module sseg  #(parameter  N = 18)
  (input  wire clk,
   input  wire [15:0] in,
   output reg [7:0] c,
   output reg [3:0] an);

  reg  [N-1:0] ctr;

  
  always @(posedge clk)
      begin
        ctr <= ctr+1'b1;
      end
  wire [1:0] digit;

  assign digit = ctr[N-1:N-(1+1)];
  reg  [3:0] val;

  
  always @(*)
      begin
        an = 4'b1111;
        an[digit] = 0;
        case (digit)

          2'b00: val = in[3:0];

          2'b01: val = in[7:4];

          2'b10: val = in[11:8];

          2'b11: val = in[15:12];

        endcase

        case (val)

          4'b0000: c = 8'b11000000;

          4'b0001: c = 8'b11111001;

          4'b0010: c = 8'b10100100;

          4'b0011: c = 8'b10110000;

          4'b0100: c = 8'b10011001;

          4'b0101: c = 8'b10010010;

          4'b0110: c = 8'b10000010;

          4'b0111: c = 8'b11111000;

          4'b1000: c = 8'b10000000;

          4'b1001: c = 8'b10010000;

          4'b1010: c = 8'b10001000;

          4'b1011: c = 8'b10000011;

          4'b1100: c = 8'b10100111;

          4'b1101: c = 8'b10100001;

          4'b1110: c = 8'b10000110;

          4'b1111: c = 8'b10001110;

          default: c = 8'b10110110;

        endcase

      end
endmodule

