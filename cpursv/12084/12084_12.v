
module stratixiv_select_ini_phase_dpaclk(clkin,loaden,enable,clkout,loadenout);

  parameter  initial_phase_select = 0;
  input  clkin;
  input  enable;
  input  loaden;
  output clkout;
  output loadenout;
  wire clkout_tmp;
  wire loadenout_tmp;
  real  clk_period,last_clk_period;
  real  last_clkin_edge;
  reg  first_clkin_edge_detect;
  reg  clk0_tmp;
  reg  clk1_tmp;
  reg  clk2_tmp;
  reg  clk3_tmp;
  reg  clk4_tmp;
  reg  clk5_tmp;
  reg  clk6_tmp;
  reg  clk7_tmp;
  reg  loaden0_tmp;
  reg  loaden1_tmp;
  reg  loaden2_tmp;
  reg  loaden3_tmp;
  reg  loaden4_tmp;
  reg  loaden5_tmp;
  reg  loaden6_tmp;
  reg  loaden7_tmp;

  assign clkout_tmp = (initial_phase_select == 1) ? clk1_tmp : 
                      (initial_phase_select == 1<<<1) ? clk2_tmp : 
                      (initial_phase_select == 3) ? clk3_tmp : 
                      (initial_phase_select == 4) ? clk4_tmp : 
                      (initial_phase_select == 5) ? clk5_tmp : 
                      (initial_phase_select == 6) ? clk6_tmp : 
                      (initial_phase_select == 7) ? clk7_tmp : clk0_tmp;
  assign loadenout_tmp = (initial_phase_select == 1) ? loaden1_tmp : 
                         (initial_phase_select == 1<<<1) ? loaden2_tmp : 
                         (initial_phase_select == 3) ? loaden3_tmp : 
                         (initial_phase_select == 4) ? loaden4_tmp : 
                         (initial_phase_select == 5) ? loaden5_tmp : 
                         (initial_phase_select == 6) ? loaden6_tmp : 
                         (initial_phase_select == 7) ? loaden7_tmp : loaden0_tmp;
  assign clkout = (enable == 1'b1) ? clkout_tmp : clkin;
  assign loadenout = (enable == 1'b1) ? loadenout_tmp : loaden;
  
  initial  
  begin
    first_clkin_edge_detect = 1'b0;
  end
  
  always @(posedge clkin)
      begin
        if (first_clkin_edge_detect == 1'b0) 
          begin
            first_clkin_edge_detect = 1'b1;
          end
        else 
          begin
            last_clk_period = clk_period;
            clk_period = (0-last_clkin_edge)+$realtime;
          end
        last_clkin_edge = $realtime;
      end
  
  always @(clkin)
      begin
        clk0_tmp <= clkin;
        clk1_tmp <= #(0.125*clk_period) clkin;
        clk2_tmp <= #(clk_period*0.25) clkin;
        clk3_tmp <= #(0.375*clk_period) clkin;
        clk4_tmp <= #(clk_period*0.5) clkin;
        clk5_tmp <= #(clk_period*0.625) clkin;
        clk6_tmp <= #(clk_period*0.75) clkin;
        clk7_tmp <= #(0.875*clk_period) clkin;
      end
  
  always @(loaden)
      begin
        loaden0_tmp <= loaden;
        loaden1_tmp <= #(0.125*clk_period) loaden;
        loaden2_tmp <= #(clk_period*0.25) loaden;
        loaden3_tmp <= #(0.375*clk_period) loaden;
        loaden4_tmp <= #(clk_period*0.5) loaden;
        loaden5_tmp <= #(clk_period*0.625) loaden;
        loaden6_tmp <= #(clk_period*0.75) loaden;
        loaden7_tmp <= #(0.875*clk_period) loaden;
      end
endmodule

