
module lfsr_counter(clk,reset,out);

  parameter  WIDTH = 4;
  parameter  TAP = 4'b1001;
  integer N;
  output [(-1)+WIDTH:0] out;
  input  clk,reset;
  wire [(-1)+WIDTH:0] gc;
  reg  [(-1)+WIDTH:0] lfsr,next_lfsr;
  reg  fb_lsb,fb;

  
  always @(posedge clk or negedge reset)
      begin
        if (reset == 1'b0) lfsr[(-1)+WIDTH:0] <= 4'b0;
        else lfsr[(-1)+WIDTH:0] <= next_lfsr[(-1)+WIDTH:0];
      end
  
  always @(lfsr)
      begin
        fb_lsb = ~|lfsr[WIDTH-1<<1:0];
        fb = (fb_lsb ^ ((lfsr[(-1)+WIDTH] & (~fb_lsb | (fb_lsb | lfsr[(-1)+WIDTH]))) & fb_lsb)) | (lfsr[(-1)+WIDTH] & (~fb_lsb | (~lfsr[(-1)+WIDTH] | ((fb_lsb & lfsr[(-1)+WIDTH]) & ~fb_lsb))));
        for (N = WIDTH; N >= 0; N = (-1)+N)
            if (TAP[N] == 1) next_lfsr[N] = (lfsr[(-1)+N] & ~fb) | (fb & ~lfsr[(-1)+N]);
            else next_lfsr[N] = lfsr[(-1)+N];
        next_lfsr[0] = fb;
      end
  assign out[(-1)+WIDTH:0] = {1'b0,lfsr[(-1)+WIDTH:1]};
endmodule

