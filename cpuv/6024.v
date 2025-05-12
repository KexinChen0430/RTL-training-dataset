module outputs
  wire [31 : 0] debug;
  wire [7 : 0] led;
  wire CLK_GATE_p200clk, RDY_debug, RDY_led, RDY_usr_sw, p200clk, p200rst;
  reg [31 : 0] freeCnt;
  wire [31 : 0] freeCnt$D_IN;
  wire freeCnt$EN;
  reg [7 : 0] swReg;
  wire [7 : 0] swReg$D_IN;
  wire swReg$EN;
  assign p200clk = sys0_clk ;
  assign CLK_GATE_p200clk = 1'd1 ;
  assign p200rst = sys0_rstn ;
  assign RDY_usr_sw = 1'd1 ;
  assign led = swReg ;
  assign RDY_led = 1'd1 ;
  assign debug = freeCnt ;
  assign RDY_debug = 1'd1 ;
  assign freeCnt$D_IN = freeCnt + 32'd1 ;
  assign freeCnt$EN = 1'd1 ;
  assign swReg$D_IN = usr_sw_i ;
  assign swReg$EN = EN_usr_sw ;
  always@(posedge sys0_clk)
  begin
    if (!sys0_rstn)
      begin
        freeCnt <= `BSV_ASSIGNMENT_DELAY 32'd0;
	swReg <= `BSV_ASSIGNMENT_DELAY 8'd0;
      end
    else
      begin
        if (freeCnt$EN) freeCnt <= `BSV_ASSIGNMENT_DELAY freeCnt$D_IN;
	if (swReg$EN) swReg <= `BSV_ASSIGNMENT_DELAY swReg$D_IN;
      end
  end
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else 
  initial
  begin
    freeCnt = 32'hAAAAAAAA;
    swReg = 8'hAA;
  end
  `endif 
endmodule