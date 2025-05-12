module outputs
  wire CACTIVE, CSYSACK;
  reg req_reg;
  wire req_reg$D_IN, req_reg$EN;
  wire CAN_FIRE_cSYSREQ, WILL_FIRE_cSYSREQ;
  assign CAN_FIRE_cSYSREQ = 1'd1 ;
  assign WILL_FIRE_cSYSREQ = 1'd1 ;
  assign CSYSACK = req_reg ;
  assign CACTIVE = 1'd1 ;
  assign req_reg$D_IN = CSYSREQ ;
  assign req_reg$EN = 1'd1 ;
  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        req_reg <= `BSV_ASSIGNMENT_DELAY 1'd1;
      end
    else
      begin
        if (req_reg$EN) req_reg <= `BSV_ASSIGNMENT_DELAY req_reg$D_IN;
      end
  end
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else 
  initial
  begin
    req_reg = 1'h0;
  end
  `endif 
endmodule