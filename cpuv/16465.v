module outputs 
  wire [15 : 0] read; 
  reg [31 : 0] taps_0; 
  wire [31 : 0] taps_0$D_IN; 
  wire taps_0$EN; 
  reg [31 : 0] taps_1; 
  wire [31 : 0] taps_1$D_IN; 
  wire taps_1$EN; 
  reg [31 : 0] taps_2; 
  wire [31 : 0] taps_2$D_IN; 
  wire taps_2$EN; 
  reg [31 : 0] taps_3; 
  wire [31 : 0] taps_3$D_IN; 
  wire taps_3$EN; 
  reg [31 : 0] y; 
  wire [31 : 0] y$D_IN; 
  wire y$EN; 
  wire [31 : 0] SEXT_y_BITS_31_TO_8__q2; 
  wire [23 : 0] y_BITS_31_TO_8__q1; 
  assign read = SEXT_y_BITS_31_TO_8__q2[15:0] ; 
  assign taps_0$D_IN = { {16{write_x[15]}}, write_x } ; 
  assign taps_0$EN = 1'd1 ; 
  assign taps_1$D_IN = taps_0 ; 
  assign taps_1$EN = 1'd1 ; 
  assign taps_2$D_IN = taps_1 ; 
  assign taps_2$EN = 1'd1 ; 
  assign taps_3$D_IN = taps_2 ; 
  assign taps_3$EN = 1'd1 ; 
  assign y$D_IN =
	     { taps_0[25:0], 6'd0 } + { taps_1[25:0], 6'd0 } +
	     { taps_2[25:0], 6'd0 } +
	     { taps_3[25:0], 6'd0 } ; 
  assign y$EN = 1'd1 ; 
  assign SEXT_y_BITS_31_TO_8__q2 =
	     { {8{y_BITS_31_TO_8__q1[23]}}, y_BITS_31_TO_8__q1 } ; 
  assign y_BITS_31_TO_8__q1 = y[31:8] ; 
  always@(posedge CLK) 
  begin
    if (RST_N == `BSV_RESET_VALUE) 
      begin
        taps_0 <= `BSV_ASSIGNMENT_DELAY 32'd0; 
	taps_1 <= `BSV_ASSIGNMENT_DELAY 32'd0; 
	taps_2 <= `BSV_ASSIGNMENT_DELAY 32'd0; 
	taps_3 <= `BSV_ASSIGNMENT_DELAY 32'd0; 
	y <= `BSV_ASSIGNMENT_DELAY 32'd0; 
      end
    else 
      begin
        if (taps_0$EN) taps_0 <= `BSV_ASSIGNMENT_DELAY taps_0$D_IN; 
	if (taps_1$EN) taps_1 <= `BSV_ASSIGNMENT_DELAY taps_1$D_IN; 
	if (taps_2$EN) taps_2 <= `BSV_ASSIGNMENT_DELAY taps_2$D_IN; 
	if (taps_3$EN) taps_3 <= `BSV_ASSIGNMENT_DELAY taps_3$D_IN; 
	if (y$EN) y <= `BSV_ASSIGNMENT_DELAY y$D_IN; 
      end
  end
  `ifdef BSV_NO_INITIAL_BLOCKS 
  `else 
  initial
  begin
    taps_0 = 32'hAAAAAAAA; 
    taps_1 = 32'hAAAAAAAA; 
    taps_2 = 32'hAAAAAAAA; 
    taps_3 = 32'hAAAAAAAA; 
    y = 32'hAAAAAAAA; 
  end
  `endif 
endmodule 