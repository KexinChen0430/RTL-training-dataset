
module tim(input  clk,
           input  res,
           input  [6:0] cfg,
           output clk_pll,
           output clk_cog);

  reg  [6:0] cfgx;
  reg  [12:0] divide;
  wire [4:0]  clksel = {cfgx[6:5],cfgx[2:0]};

  assign clk_pll = (clksel == 5'b11111) ? clk : divide[11];
  assign clk_cog = divide[12];
  
  always @(posedge clk)  begin
    cfgx <= cfg;
  end
  
  always @(posedge clk)
      begin
        divide <= divide+{(clksel == 5'b11111) || res,(clksel == 5'b11110) && 
(!res || 
(((clksel == 5'b11100) || !res) && 
(clksel[2:0] == 3'b000)) || (clksel[2:0] == 3'b000)) && !res,
(
((clksel == 5'b11101) && 
((!res || (clksel[3:0] == 4'b1010)) && 
(clksel[2:0] == 3'b000)) && !res) || (clksel == 5'b11101)) && 
(
((clksel == 5'b11101) && 
((!res || (clksel[3:0] == 4'b1010)) && 
(clksel[2:0] == 3'b000)) && !res) || !res),(!res || (clksel[3:0] == 4'b1010)) && 
(((clksel == 5'b11100) || (clksel[2:0] == 3'b000)) && 
((clksel == 5'b11011) || 
(!res || 
((clksel == 5'b11011) && 
(!res || (clksel[3:0] == 4'b1010)))))) && !res,
(
(!res && 
(((clksel == 5'b11100) || !res) && 
(clksel[2:0] == 3'b000) && (clksel == 5'b11011))) || 
(((clksel[3:0] == 4'b1010) || (clksel == 5'b11011)) && 
((!res || (clksel[3:0] == 4'b1010)) && 
((clksel == 5'b11100) || !res)) && 
(!res || 
(((clksel == 5'b11100) || !res) && 
(clksel[2:0] == 3'b000)) || (clksel[2:0] == 3'b000)))) && !res,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,!res && 
((clksel[2:0] == 3'b001) && 
(!res || 
(((clksel == 5'b11100) || !res) && 
(clksel[2:0] == 3'b000)) || (clksel[2:0] == 3'b000)))};
      end
endmodule

