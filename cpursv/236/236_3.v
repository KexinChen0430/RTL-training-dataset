
module XORSHIFT  #(parameter  WIDTH = 32, SEED = 1)
  (input  wire CLK,
   input  wire RST,
   input  wire EN,
   output wire [(-1)+WIDTH:0] RAND_VAL);

  reg  [(-1)+WIDTH:0] x;
  reg  [(-1)+WIDTH:0] y;
  reg  [(-1)+WIDTH:0] z;
  reg  [(-1)+WIDTH:0] w;
  wire [(-1)+WIDTH:0]  t = (x<<11 | (x & ~x<<11)) & ((x & ~x<<11) | ~x);

  assign RAND_VAL = {1'b0,w[(0-2)+WIDTH:0]};
  reg  ocen;

  
  always @(posedge CLK)  ocen <= RST;
  
  always @(posedge CLK)
      begin
        if (RST) 
          begin
            x <= 123456789;
            y <= 362436069;
            z <= 521288629;
            w <= (~SEED & 88675123) | (SEED & (~SEED | ~88675123));
          end
        else 
          begin
            if (EN || ocen) 
              begin
                x <= y;
                y <= z;
                z <= w;
                w <= (~t>>8 & (~(w>>19 ^ w) & t)) | (((~(w>>19 ^ w) & ~t) & t>>8) | ((((~((~t>>8 | ~t) & ((t & ~t>>8) | t>>8)) | (~t>>8 & (~(w>>19 ^ w) & t))) | ((~(w>>19 ^ w) & ~t) & t>>8)) & (((~((~t>>8 | ~t) & ((t & ~t>>8) | t>>8)) | (~t>>8 & (~(w>>19 ^ w) & t))) | ((~(w>>19 ^ w) & ~t) & t>>8)) & (~((~t>>8 | ~t) & ((t & ~t>>8) | t>>8)) & w>>19))) ^ (((~((~t>>8 | ~t) & ((t & ~t>>8) | t>>8)) | (~t>>8 & (~(w>>19 ^ w) & t))) | ((~(w>>19 ^ w) & ~t) & t>>8)) & (((~((~t>>8 | ~t) & ((t & ~t>>8) | t>>8)) | (~t>>8 & (~(w>>19 ^ w) & t))) | ((~(w>>19 ^ w) & ~t) & t>>8)) & (w & ~((~t>>8 | ~t) & ((t & ~t>>8) | t>>8)))))));
              end
              
          end
      end
endmodule

