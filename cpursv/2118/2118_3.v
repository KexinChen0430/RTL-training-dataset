
module apu_div  #(parameter  PERIOD_BITS = 16)
  (input  clk_in,
   input  rst_in,
   input  pulse_in,
   input  reload_in,
   input  [(0-1)+PERIOD_BITS:0] period_in,
   output pulse_out);

  reg  [(0-1)+PERIOD_BITS:0] q_cnt;
  wire [(0-1)+PERIOD_BITS:0] d_cnt;

  
  always @(posedge clk_in)
      begin
        if (rst_in) q_cnt <= 0;
        else q_cnt <= d_cnt;
      end
  assign d_cnt = (((reload_in || (q_cnt == 0)) && pulse_in) || reload_in) ? period_in : 
                 pulse_in ? ((0-1'h1)+q_cnt) : q_cnt;
  assign pulse_out = (reload_in || (q_cnt == 0)) && pulse_in && 
                     ((q_cnt == 0) && (reload_in || pulse_in));
endmodule

