
module lfsr3(input  clk,
             input  step,
             input  rst,
             output value);

  reg  [7:0]  lfsr = 0;
  wire 
       feedback = ((((~(lfsr[5] ^ lfsr[7]) | (~lfsr[7] & lfsr[5])) | (~lfsr[5] & lfsr[7])) & ((~(((((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | (lfsr[4] | ((lfsr[7] & ~(~lfsr[4] & lfsr[5])) & ~lfsr[4]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (~lfsr[4] & lfsr[7])))) ^ (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | (lfsr[4] | ((lfsr[7] & ~(~lfsr[4] & lfsr[5])) & ~lfsr[4]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (~lfsr[4] & lfsr[5]))))) | (lfsr[4] & ~(lfsr[5] ^ lfsr[7]))) | ~lfsr[3]) & (lfsr[4] & ~lfsr[3]))) ^ (((~(lfsr[5] ^ lfsr[7]) | (~lfsr[7] & lfsr[5])) | (~lfsr[5] & lfsr[7])) & ((~(((((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | (lfsr[4] | ((lfsr[7] & ~(~lfsr[4] & lfsr[5])) & ~lfsr[4]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (~lfsr[4] & lfsr[7])))) ^ (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | (lfsr[4] | ((lfsr[7] & ~(~lfsr[4] & lfsr[5])) & ~lfsr[4]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (~lfsr[4] & lfsr[5]))))) | (lfsr[4] & ~(lfsr[5] ^ lfsr[7]))) | ~lfsr[3]) & ((lfsr[7] | (~lfsr[7] & lfsr[5])) & ((~lfsr[7] | (~lfsr[5] & lfsr[7])) & ~lfsr[3]))))) | (~(((((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | (lfsr[4] | ((lfsr[7] & ~(~lfsr[4] & lfsr[5])) & ~lfsr[4]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (~lfsr[4] & lfsr[7])))) ^ (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | (lfsr[4] | ((lfsr[7] & ~(~lfsr[4] & lfsr[5])) & ~lfsr[4]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (((~lfsr[4] & (~(~lfsr[4] & lfsr[7]) & lfsr[5])) | ((~(lfsr[5] ^ lfsr[7]) | (~lfsr[4] & ~(~lfsr[4] & lfsr[5]))) & (~(lfsr[5] ^ lfsr[7]) | lfsr[7]))) & (~lfsr[4] & lfsr[5]))))) | (lfsr[4] & ~(lfsr[5] ^ lfsr[7]))) & lfsr[3]);

  
  always @(posedge clk)
      if (rst) lfsr <= lfsr+1;
      else if (step) lfsr <= {lfsr[6:0],feedback};
        
  assign value = ((lfsr[3] & (lfsr[5] & lfsr[6])) & lfsr[7]) & lfsr[4];
endmodule

