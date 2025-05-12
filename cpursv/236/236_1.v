
module XORSHIFT  #(parameter  WIDTH = 32, SEED = 1)
  (input  wire CLK,
   input  wire RST,
   input  wire EN,
   output wire [(0-1)+WIDTH:0] RAND_VAL);

  reg  [(0-1)+WIDTH:0] x;
  reg  [(0-1)+WIDTH:0] y;
  reg  [(0-1)+WIDTH:0] z;
  reg  [(0-1)+WIDTH:0] w;
  wire [(0-1)+WIDTH:0] 
       t = (~(x*(2**11)) & ((~(x*(2**11)) | ~x) & x)) | (((x*(2**11)) & ~x) | ((x*(2**11)) & ~(x*(2**11))));

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
            w <= (SEED & (~88675123 | ~SEED)) | (~SEED & 88675123);
          end
        else 
          begin
            if (ocen || EN) 
              begin
                x <= y;
                y <= z;
                z <= w;
                w <= (~((~t & t>>8) | (t & ~t>>8)) | ((((~((~w>>19 & ((w>>19 | w) & (w | ~w))) | (~w & w>>19)) & ~t) | ~t>>8) & ((~((~w>>19 & ((w>>19 | w) & (w | ~w))) | (~w & w>>19)) & ~t) | (~((~w>>19 & ((w>>19 | w) & (w | ~w))) | (~w & w>>19)) & t))) & ((~t | t) & (t>>8 | t)))) & (((((~((~w>>19 & ((w>>19 | w) & (w | ~w))) | (~w & w>>19)) & ~t) | ~t>>8) & ((~((~w>>19 & ((w>>19 | w) & (w | ~w))) | (~w & w>>19)) & ~t) | (~((~w>>19 & ((w>>19 | w) & (w | ~w))) | (~w & w>>19)) & t))) & ((~t | t) & (t>>8 | t))) | ((~((~t & t>>8) | (t & ~t>>8)) & (~w>>19 & w)) | (~w & w>>19)));
              end
              
          end
      end
endmodule

