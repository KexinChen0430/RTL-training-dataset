
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
        fb_lsb = ~|lfsr[WIDTH-2:0];
        fb = ((~lfsr[(-1)+WIDTH] | (fb_lsb | lfsr[(-1)+WIDTH])) & ((~lfsr[(-1)+WIDTH] | (fb_lsb | lfsr[(-1)+WIDTH])) & fb_lsb)) ^ lfsr[(-1)+WIDTH];
        for (N = WIDTH; N >= 0; N = N-1)
            if (TAP[N] == 1) 
              next_lfsr[N] = ((~fb | fb) & ((~lfsr[N-1] | lfsr[N-1]) & fb)) ^ (((~lfsr[N-1] | lfsr[N-1]) & ((~fb | fb) & lfsr[N-1])) & (~fb | fb));
            else next_lfsr[N] = lfsr[N-1];
        next_lfsr[0] = fb;
      end
  assign out[(-1)+WIDTH:0] = {1'b0,lfsr[(-1)+WIDTH:1]};
endmodule

