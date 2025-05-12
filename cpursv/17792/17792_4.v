
module hi_read_tx(input  pck0,ck_1356meg,ck_1356megb,
                  input  [7:0] adc_d,
                  input  ssp_dout,
                  input  cross_hi,cross_lo,
                  input  shallow_modulation,
                  output pwr_lo,pwr_hi,
                  output pwr_oe1,pwr_oe2,pwr_oe3,pwr_oe4,
                  output adc_clk,
                  output ssp_frame,ssp_din,ssp_clk,
                  output dbg);

  assign pwr_lo = 1'b0;
  assign pwr_oe2 = 1'b0;
  reg  pwr_hi;

  reg  pwr_oe1;

  reg  pwr_oe3;

  reg  pwr_oe4;

  
  always @(ck_1356megb or ssp_dout or shallow_modulation)
      begin
        if (shallow_modulation) 
          begin
            pwr_hi <= ck_1356megb;
            pwr_oe1 <= 1'b0;
            pwr_oe3 <= 1'b0;
            pwr_oe4 <= ~ssp_dout;
          end
        else 
          begin
            pwr_hi <= ssp_dout & ck_1356megb;
            pwr_oe1 <= 1'b0;
            pwr_oe3 <= 1'b0;
            pwr_oe4 <= 1'b0;
          end
      end
  reg  [6:0] hi_div_by_128;

  
  always @(posedge ck_1356meg)
      hi_div_by_128 <= hi_div_by_128+1;
  assign ssp_clk = hi_div_by_128[6];
  reg  [2:0] hi_byte_div;

  
  always @(negedge ssp_clk)
      hi_byte_div <= hi_byte_div+1;
  assign ssp_frame = hi_byte_div == 3'b000;
  assign adc_clk = ck_1356meg;
  reg  after_hysteresis;

  
  always @(negedge adc_clk)
      begin
        if (&adc_d[7:0]) after_hysteresis <= 1'b1;
        else if (~|adc_d[7:0]) after_hysteresis <= 1'b0;
          
      end
  assign ssp_din = after_hysteresis;
  assign dbg = ssp_din;
endmodule

