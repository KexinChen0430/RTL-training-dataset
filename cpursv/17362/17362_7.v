
module lfsr_counter(clk,reset,out);

  parameter  WIDTH = 4;
  parameter  TAP = 4'b1001;
  integer N;
  output [WIDTH+(0-1):0] out;
  input  clk,reset;
  wire [WIDTH+(0-1):0] gc;
  reg  [WIDTH+(0-1):0] lfsr,next_lfsr;
  reg  fb_lsb,fb;

  
  always @(posedge clk or negedge reset)
      begin
        if (reset == 1'b0) lfsr[WIDTH+(0-1):0] <= 4'b0;
        else lfsr[WIDTH+(0-1):0] <= next_lfsr[WIDTH+(0-1):0];
      end
  
  always @(lfsr)
      begin
        fb_lsb = ~|lfsr[(0-1<<<1)+WIDTH:0];
        fb = (~fb_lsb | (~lfsr[WIDTH+(0-1)] & fb_lsb)) & ((~lfsr[WIDTH+(0-1)] & (lfsr[WIDTH+(0-1)] | (~lfsr[WIDTH+(0-1)] & fb_lsb))) | ((lfsr[WIDTH+(0-1)] & ~fb_lsb) | (lfsr[WIDTH+(0-1)] & ~lfsr[WIDTH+(0-1)])));
        for (N = WIDTH; N >= 0; N = (0-1)+N)
            if (TAP[N] == 1) 
              next_lfsr[N] = ((fb & ~lfsr[(0-1)+N]) | (fb & lfsr[(0-1)+N])) ^ lfsr[(0-1)+N];
            else next_lfsr[N] = lfsr[(0-1)+N];
        next_lfsr[0] = fb;
      end
  assign out[WIDTH+(0-1):0] = {1'b0,lfsr[WIDTH+(0-1):1]};
endmodule

