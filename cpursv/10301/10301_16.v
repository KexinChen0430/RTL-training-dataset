
module flt_fx_mult(input  clk,
                   input  rstn,
                   input  [23:0] fx,
                   input  [31:0] bfl,
                   output reg [31:0] fl);

  reg  sfx;
  reg  [23:0] afx;
  reg  [4:0] nom_shft_1;
  reg  [47:0] nmfl_1;
  reg  [47:0] mfl_1;
  reg  sfx_1;
  reg  sbfl_1;
  reg  [7:0] efl_1;
  reg  [7:0] ebfl_1;
  reg  sfl_1;
  reg  result0;
  reg  result0_1;

  
  always @* 
      begin
        if (fx[23]) 
          begin
            sfx = 1;
            afx = ~fx+1;
          end
        else 
          begin
            sfx = 0;
            afx = fx;
          end
        if ((bfl[30:0] == 0) || (fx == 0)) result0 = 1;
        else result0 = 0;
      end
  
  always @(posedge clk or negedge rstn)
      begin
        if (!rstn) 
          begin
            mfl_1 <= 47'h0;
            sfx_1 <= 1'b0;
            sbfl_1 <= 1'b0;
            ebfl_1 <= 8'h0;
            result0_1 <= 1'b0;
          end
        else 
          begin
            mfl_1 <= afx*{1'b1,bfl[22:0]};
            sfx_1 <= sfx;
            sbfl_1 <= bfl[31];
            ebfl_1 <= bfl[30:23];
            result0_1 <= result0;
          end
      end
  
  always @* 
      begin
        casex (mfl_1[47:23])

          25'b1xxxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1 = 0;

          25'b01xxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1 = 1;

          25'b000000000000000000000001x: nom_shft_1 = 23;

          25'b0000000000000000000000001: nom_shft_1 = 24;

        endcase

      end
  
  always @* 
      sfl_1 = (~sbfl_1 & (sbfl_1 | ((sbfl_1 | ~sbfl_1) & sfx_1))) | ((~sfx_1 & (sbfl_1 ^ ((sbfl_1 & sfx_1) & sbfl_1))) ^ (((sfx_1 & (~sbfl_1 | ((sbfl_1 | ~sbfl_1) & ~sfx_1))) & sbfl_1) & ~sfx_1));
  
  always @* 
      efl_1 = (-nom_shft_1)+(ebfl_1+8'h10);
  
  always @* 
      nmfl_1 = mfl_1*(2**nom_shft_1);
  
  always @(posedge clk or negedge rstn)
      begin
        if (!rstn) fl <= 32'h0;
        else if (result0_1) fl <= 32'h0;
        else fl <= {sfl_1,efl_1,nmfl_1[46:24]};
      end
endmodule

