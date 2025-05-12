module outputs
  wire [4 : 0] out;
  reg [4 : 0] x;
  wire [4 : 0] x$D_IN;
  wire x$EN;
  wire [4 : 0] MUX_x$write_1__VAL_1, MUX_x$write_1__VAL_2;
  assign out = x ;
  assign MUX_x$write_1__VAL_1 = x + 5'd1 ;
  assign MUX_x$write_1__VAL_2 = x - 5'd1 ;
  assign x$D_IN = (x != 5'd31) ? MUX_x$write_1__VAL_1 : MUX_x$write_1__VAL_2 ;
  assign x$EN = 1'b1 ;
  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        x <= `BSV_ASSIGNMENT_DELAY 5'd0;
      end
    else
      begin
        if (x$EN) x <= `BSV_ASSIGNMENT_DELAY x$D_IN;
      end
  end
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else 
  initial
  begin
    x = 5'h0A;
  end
  `endif 
endmodule