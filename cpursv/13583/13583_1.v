
module clk_global(clkselect,inclk0x,inclk1x,inclk2x,inclk3x,outclk);

  input  [1:0] clkselect;
  input  inclk0x;
  input  inclk1x;
  input  inclk2x;
  input  inclk3x;
  output outclk;
  tri0 [1:0] clkselect;
  wire sub_wire0;
  wire  sub_wire1 = 1'h1;
  wire  sub_wire6 = inclk3x;
  wire  sub_wire5 = inclk2x;
  wire  sub_wire4 = inclk1x;
  wire  outclk = sub_wire0;
  wire  sub_wire2 = inclk0x;
  wire [3:0] 
       sub_wire3 = {sub_wire6,sub_wire5,sub_wire4,sub_wire2};

  clk_global_altclkctrl_9bf clk_global_altclkctrl_9bf_component(.clkselect(clkselect),
                                                                .ena(sub_wire1),.inclk(sub_wire3),
                                                                .outclk(sub_wire0));
endmodule

