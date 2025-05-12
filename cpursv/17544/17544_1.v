
module s8(clk,b,so);

  input  clk;
  input  [1:6] b;
  output [1:4] so;
  reg  [1:4] so;

  
  always @(posedge clk)
      casex (b)

        6'b000000: so = 4'hd;

        6'b000010: so = 4'h2;

        6'b000100: so = 4'h8;

        6'b000110: so = 4'h4;

        6'b001000: so = 4'h6;

        6'b001010: so = 4'hf;

        6'b001100: so = 4'hb;

        6'b001110: so = 4'h1;

        6'b010000: so = 4'ha;

        6'b010010: so = 4'h9;

        6'b010100: so = 4'h3;

        6'b010110: so = 4'he;

        6'b011000: so = 4'h5;

        6'b011010: so = 4'h0;

        6'b011100: so = 4'hc;

        6'b011110: so = 4'h7;

        6'b000001: so = 4'h1;

        6'b000011: so = 4'hf;

        default: so = 4'hb;

      endcase

endmodule

