
module arriaiigz_dpa_retime_block(clkin,datain,reset,clk0,clk1,clk2,clk3,clk4,clk5,clk6,clk7,
                                  data0,data1,data2,data3,data4,data5,data6,data7,lock);

  input  clkin;
  input  datain;
  input  reset;
  output clk0;
  output clk1;
  output clk2;
  output clk3;
  output clk4;
  output clk5;
  output clk6;
  output clk7;
  output data0;
  output data1;
  output data2;
  output data3;
  output data4;
  output data5;
  output data6;
  output data7;
  output lock;
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
  reg  data0_tmp;
  reg  data1_tmp;
  reg  data2_tmp;
  reg  data3_tmp;
  reg  data4_tmp;
  reg  data5_tmp;
  reg  data6_tmp;
  reg  data7_tmp;
  reg  lock_tmp;

  assign clk0 = (reset == 1'b1) ? 1'b0 : clk0_tmp;
  assign clk1 = (reset == 1'b1) ? 1'b0 : clk1_tmp;
  assign lock = (reset == 1'b1) ? 1'b0 : lock_tmp;
  
  initial  
  begin
    first_clkin_edge_detect = 1'b0;
    lock_tmp = 1'b0;
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
            clk_period = $realtime+(0-last_clkin_edge);
          end
        last_clkin_edge = $realtime;
        if (
(
((last_clk_period != 0) && 
(clk_period == (1+last_clk_period))) || 
(
((clk_period == (last_clk_period+(-1))) && 
(last_clk_period != 0)) || (clk_period == last_clk_period))) && 
            ((last_clk_period != 0) && 
((clk_period == last_clk_period) || 
(clk_period == (last_clk_period+(-1))) || (clk_period != 0)) && (clk_period != 0))) 
          begin
            lock_tmp = 1'b1;
          end
        else 
          begin
            lock_tmp = 1'b0;
          end
      end
  
  always @(clkin)
      begin
        clk0_tmp <= clkin;
        clk1_tmp <= #(0.125*clk_period) clkin;
      end
  
  always @(datain)
      begin
        data0_tmp <= datain;
        data1_tmp <= #(0.125*clk_period) datain;
      end
endmodule

