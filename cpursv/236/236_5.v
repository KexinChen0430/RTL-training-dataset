
module XORSHIFT  #(parameter  WIDTH = 32, SEED = 1)
  (input  wire CLK,
   input  wire RST,
   input  wire EN,
   output wire [WIDTH-1:0] RAND_VAL);

  reg  [WIDTH-1:0] x;
  reg  [WIDTH-1:0] y;
  reg  [WIDTH-1:0] z;
  reg  [WIDTH-1:0] w;
  wire [WIDTH-1:0]  t = x ^ x<<<11;

  assign RAND_VAL = {1'b0,w[WIDTH-2:0]};
  reg  ocen;

  
  always @(posedge CLK)  ocen <= RST;
  
  always @(posedge CLK)
      begin
        if (RST) 
          begin
            x <= 123456789;
            y <= 362436069;
            z <= 521288629;
            w <= ((((SEED & (~SEED & 88675123)) | (~88675123 & SEED)) | (~88675123 | (~SEED & 88675123))) & ((~88675123 | 88675123) & 88675123)) ^ ((((SEED & (~SEED & 88675123)) | (~88675123 & SEED)) | (~88675123 | (~SEED & 88675123))) & ((~88675123 | 88675123) & SEED));
          end
        else 
          begin
            if (EN || ocen) 
              begin
                x <= y;
                y <= z;
                z <= w;
                w <= (t & (~(((w>>19 | ~w>>19) & ((~w | w) & w>>19)) ^ ((w>>19 | ~w>>19) & ((~w | w) & w))) & ~t>>8)) | ((t>>8 & (~t & ~(((w>>19 | ~w>>19) & ((~w | w) & w>>19)) ^ ((w>>19 | ~w>>19) & ((~w | w) & w))))) | ((((w>>19 | ~w>>19) & ((~w | w) & w>>19)) ^ ((w>>19 | ~w>>19) & ((~w | w) & w))) & ~((t & ~t>>8) | (t>>8 & ~t))));
              end
              
          end
      end
endmodule

