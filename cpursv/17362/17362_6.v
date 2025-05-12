
module lfsr_counter(clk,reset,out);

  parameter  WIDTH = 4;
  parameter  TAP = 4'b1001;
  integer N;
  output [(0-1)+WIDTH:0] out;
  input  clk,reset;
  wire [(0-1)+WIDTH:0] gc;
  reg  [(0-1)+WIDTH:0] lfsr,next_lfsr;
  reg  fb_lsb,fb;

  
  always @(posedge clk or negedge reset)
      begin
        if (reset == 1'b0) lfsr[(0-1)+WIDTH:0] <= 4'b0;
        else lfsr[(0-1)+WIDTH:0] <= next_lfsr[(0-1)+WIDTH:0];
      end
  
  always @(lfsr)
      begin
        fb_lsb = ~|lfsr[(0-1<<1)+WIDTH:0];
        fb = lfsr[(0-1)+WIDTH] ^ ((~lfsr[(0-1)+WIDTH] | lfsr[(0-1)+WIDTH]) & ((fb_lsb & ~lfsr[(0-1)+WIDTH]) | (lfsr[(0-1)+WIDTH] & fb_lsb)));
        for (N = WIDTH; N >= 0; N = N+(0-1))
            if (TAP[N] == 1) next_lfsr[N] = lfsr[N+(0-1)] ^ fb;
            else next_lfsr[N] = lfsr[N+(0-1)];
        next_lfsr[0] = fb;
      end
  assign out[(0-1)+WIDTH:0] = {1'b0,lfsr[(0-1)+WIDTH:1]};
endmodule

