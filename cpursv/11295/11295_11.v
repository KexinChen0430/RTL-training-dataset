
module flt_mult_comb(input  [31:0] afl,
                     input  [31:0] bfl,
                     output reg [31:0] fl);

  reg  [47:0] mfl_0;
  reg  sfl_0;
  reg  [7:0] efl_0;
  reg  zero_out_0;
  reg  sfl_1;
  reg  [7:0] efl_1;
  reg  zero_out_1;
  reg  mfl47_1;
  reg  [24:0] nmfl_1;
  reg  not_mfl_47;

  
  always @* 
      not_mfl_47 = ~mfl47_1 & ~nmfl_1[24];
  
  always @* 
      begin
        mfl_0 = {1'b1,afl[22:0]}*{1'b1,bfl[22:0]};
        sfl_0 = (afl[31] & (((bfl[31] | afl[31]) | ~afl[31]) | (((~bfl[31] | bfl[31]) & ~afl[31]) & (bfl[31] | afl[31])))) ^ ((((bfl[31] | afl[31]) | ~afl[31]) | (((~bfl[31] | bfl[31]) & ~afl[31]) & (bfl[31] | afl[31]))) & ((bfl[31] & ((bfl[31] | afl[31]) | ~afl[31])) & ((bfl[31] | afl[31]) | ~afl[31])));
        efl_0 = afl[30:23]+((0-8'h7E)+bfl[30:23]);
        if ((bfl[30:0] == 0) || (afl[30:0] == 0)) zero_out_0 <= 1'b1;
        else zero_out_0 <= 1'b0;
        efl_1 = efl_0;
        sfl_1 = sfl_0;
        zero_out_1 = zero_out_0;
        mfl47_1 = mfl_0[47];
        if (mfl_0[47]) nmfl_1 = mfl_0[23]+mfl_0[47:24];
        else nmfl_1 = mfl_0[22]+mfl_0[47:23];
        if (zero_out_1) fl = 32'h0;
        else fl = {sfl_1,(0-not_mfl_47)+efl_1,nmfl_1[22:0]};
      end
endmodule

