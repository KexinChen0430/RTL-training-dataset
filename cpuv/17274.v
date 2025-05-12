module outputs 
  wire [31 : 0] result; 
  wire RDY_result, RDY_start; 
  reg [31 : 0] x; 
  wire [31 : 0] x$D_IN; 
  wire x$EN; 
  reg [31 : 0] y; 
  wire [31 : 0] y$D_IN; 
  wire y$EN; 
  wire [31 : 0] MUX_x$write_1__VAL_2, MUX_y$write_1__VAL_2; 
  wire x_ULE_y___d3; 
  assign RDY_start = y == 32'd0 ; 
  assign result = x ; 
  assign RDY_result = y == 32'd0 ; 
  assign MUX_x$write_1__VAL_2 = x - y ; 
  assign MUX_y$write_1__VAL_2 = y - x ; 
  assign x$D_IN = EN_start ? start_a : MUX_x$write_1__VAL_2 ; 
  assign x$EN = EN_start || !x_ULE_y___d3 && y != 32'd0 ; 
  assign y$D_IN = EN_start ? start_b : MUX_y$write_1__VAL_2 ; 
  assign y$EN = EN_start || x_ULE_y___d3 && y != 32'd0 ; 
  assign x_ULE_y___d3 = x <= y ; 
  always@(posedge CLK) 
  begin
    if (RST_N == `BSV_RESET_VALUE) 
      begin
        x <= `BSV_ASSIGNMENT_DELAY 32'd0; 
	y <= `BSV_ASSIGNMENT_DELAY 32'd0; 
      end
    else 
      begin
        if (x$EN) x <= `BSV_ASSIGNMENT_DELAY x$D_IN; 
	if (y$EN) y <= `BSV_ASSIGNMENT_DELAY y$D_IN; 
      end
  end
  `ifdef BSV_NO_INITIAL_BLOCKS 
  `else 
  initial 
  begin
    x = 32'hAAAAAAAA; 
    y = 32'hAAAAAAAA; 
  end
  `endif 
endmodule 