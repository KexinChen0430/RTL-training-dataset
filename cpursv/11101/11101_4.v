
module freq_div  #(parameter 
       divisor_width    = 8,
       duty_cycle_width = divisor_width)
  (output reg out_clk,
   input  [(-1)+divisor_width:0] divisor,
   input  [duty_cycle_width+(-1):0] duty_cycle,
   input  reset_l,in_clk);

  reg  [(-1)+divisor_width:0] div_track;

  
  always @(in_clk)
      begin
        div_track <= 1+div_track;
      end
  reg  [divisor_width:0] ct;

  wire  d_high = duty_cycle[duty_cycle_width+(-1)];

  wire [duty_cycle_width+(-1<<1):0]  d_low = duty_cycle[duty_cycle_width+(-1<<1):0];

  
  always @(div_track)
      begin
        if (out_clk) 
          if (d_high) ct = d_low+divisor;
          else ct = divisor-d_low;
        else if (d_high) ct = divisor-d_low;
        else ct = d_low+divisor;
        if (div_track >= ct) 
          begin
            out_clk <= ~out_clk;
            div_track <= 0;
          end
          
      end
  
  always @(reset_l)
      begin
        if (reset_l == 0) 
          begin
            out_clk <= 0;
            div_track <= 0;
          end
          
      end
endmodule

