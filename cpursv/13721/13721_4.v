
module red_pitaya_prng_lehmer  #(parameter 
       A         = 48271,
       B         = 323485697,
       SEED      = 901448241,
       STATEBITS = 31,
       OUTBITS   = 14)
  (input  clk_i,
   input  reset_i,
   output signed  [(0-1)+OUTBITS:0] signal_o);

  reg  [(0-1)+STATEBITS:0] xn;
  wire [(0-1)+STATEBITS:0] xn_wire;
  reg  [(0-1)+STATEBITS:0] b;
  reg  [16+(0-1):0] a;

  
  always @(posedge clk_i)
      if (reset_i == 1'b0) 
        begin
          a <= A;
          b <= B;
          xn <= SEED;
        end
      else 
        begin
          xn <= (&xn_wire == 1'b1) ? {STATEBITS{1'b0}} : xn_wire;
        end
  assign xn_wire = (xn*a)+b;
  assign signal_o = xn[(0-1)+STATEBITS:(-OUTBITS)+STATEBITS];
endmodule

