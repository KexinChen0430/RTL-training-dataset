module outputs
  wire [127 : 0] result_value;
  wire result_valid;
  reg m_rg_isNeg;
  wire m_rg_isNeg$D_IN, m_rg_isNeg$EN;
  reg m_rg_signed;
  wire m_rg_signed$D_IN, m_rg_signed$EN;
  reg [1 : 0] m_rg_state;
  wire [1 : 0] m_rg_state$D_IN;
  wire m_rg_state$EN;
  reg [127 : 0] m_rg_x;
  wire [127 : 0] m_rg_x$D_IN;
  wire m_rg_x$EN;
  reg [127 : 0] m_rg_xy;
  wire [127 : 0] m_rg_xy$D_IN;
  wire m_rg_xy$EN;
  reg [63 : 0] m_rg_y;
  wire [63 : 0] m_rg_y$D_IN;
  wire m_rg_y$EN;
  wire CAN_FIRE_RL_m_compute,
       CAN_FIRE_put_args,
       WILL_FIRE_RL_m_compute,
       WILL_FIRE_put_args;
  wire [127 : 0] MUX_m_rg_x$write_1__VAL_1,
		 MUX_m_rg_x$write_1__VAL_2,
		 MUX_m_rg_xy$write_1__VAL_2;
  wire [63 : 0] MUX_m_rg_y$write_1__VAL_1, MUX_m_rg_y$write_1__VAL_2;
  wire [127 : 0] x__h236, x__h338, xy___1__h262;
  wire [63 : 0] _theResult___fst__h506,
		_theResult___fst__h509,
		_theResult___fst__h560,
		_theResult___fst__h563,
		_theResult___snd_fst__h555;
  wire IF_put_args_x_is_signed_THEN_put_args_x_BIT_63_ETC___d34;
  assign CAN_FIRE_put_args = 1'd1 ;
  assign WILL_FIRE_put_args = EN_put_args ;
  assign result_valid = m_rg_state == 2'd2 ;
  assign result_value = m_rg_xy ;
  assign CAN_FIRE_RL_m_compute = m_rg_state == 2'd1 ;
  assign WILL_FIRE_RL_m_compute = CAN_FIRE_RL_m_compute ;
  assign MUX_m_rg_x$write_1__VAL_1 = { 64'd0, _theResult___fst__h506 } ;
  assign MUX_m_rg_x$write_1__VAL_2 = { m_rg_x[126:0], 1'd0 } ;
  assign MUX_m_rg_xy$write_1__VAL_2 = (m_rg_y == 64'd0) ? x__h236 : x__h338 ;
  assign MUX_m_rg_y$write_1__VAL_1 =
	     (put_args_x_is_signed && put_args_y_is_signed) ?
	       _theResult___fst__h563 :
	       _theResult___snd_fst__h555 ;
  assign MUX_m_rg_y$write_1__VAL_2 = { 1'd0, m_rg_y[63:1] } ;
  assign m_rg_isNeg$D_IN =
	     (put_args_x_is_signed && put_args_y_is_signed) ?
	       put_args_x[63] != put_args_y[63] :
	       IF_put_args_x_is_signed_THEN_put_args_x_BIT_63_ETC___d34 ;
  assign m_rg_isNeg$EN = EN_put_args ;
  assign m_rg_signed$D_IN = 1'b0 ;
  assign m_rg_signed$EN = 1'b0 ;
  assign m_rg_state$D_IN = EN_put_args ? 2'd1 : 2'd2 ;
  assign m_rg_state$EN =
	     WILL_FIRE_RL_m_compute && m_rg_y == 64'd0 || EN_put_args ;
  assign m_rg_x$D_IN =
	     EN_put_args ?
	       MUX_m_rg_x$write_1__VAL_1 :
	       MUX_m_rg_x$write_1__VAL_2 ;
  assign m_rg_x$EN =
	     WILL_FIRE_RL_m_compute && m_rg_y != 64'd0 || EN_put_args ;
  assign m_rg_xy$D_IN = EN_put_args ? 128'd0 : MUX_m_rg_xy$write_1__VAL_2 ;
  assign m_rg_xy$EN =
	     WILL_FIRE_RL_m_compute && (m_rg_y == 64'd0 || m_rg_y[0]) ||
	     EN_put_args ;
  assign m_rg_y$D_IN =
	     EN_put_args ?
	       MUX_m_rg_y$write_1__VAL_1 :
	       MUX_m_rg_y$write_1__VAL_2 ;
  assign m_rg_y$EN =
	     WILL_FIRE_RL_m_compute && m_rg_y != 64'd0 || EN_put_args ;
  assign IF_put_args_x_is_signed_THEN_put_args_x_BIT_63_ETC___d34 =
	     put_args_x_is_signed ?
	       put_args_x[63] :
	       put_args_y_is_signed && put_args_y[63] ;
  assign _theResult___fst__h506 =
	     put_args_x_is_signed ? _theResult___fst__h509 : put_args_x ;
  assign _theResult___fst__h509 = put_args_x[63] ? -put_args_x : put_args_x ;
  assign _theResult___fst__h560 =
	     put_args_y_is_signed ? _theResult___fst__h563 : put_args_y ;
  assign _theResult___fst__h563 = put_args_y[63] ? -put_args_y : put_args_y ;
  assign _theResult___snd_fst__h555 =
	     put_args_x_is_signed ? put_args_y : _theResult___fst__h560 ;
  assign x__h236 = m_rg_isNeg ? xy___1__h262 : m_rg_xy ;
  assign x__h338 = m_rg_xy + m_rg_x ;
  assign xy___1__h262 = -m_rg_xy ;
  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        m_rg_state <= `BSV_ASSIGNMENT_DELAY 2'd0;
      end
    else
      begin
        if (m_rg_state$EN)
	  m_rg_state <= `BSV_ASSIGNMENT_DELAY m_rg_state$D_IN;
      end
    if (m_rg_isNeg$EN) m_rg_isNeg <= `BSV_ASSIGNMENT_DELAY m_rg_isNeg$D_IN;
    if (m_rg_signed$EN) m_rg_signed <= `BSV_ASSIGNMENT_DELAY m_rg_signed$D_IN;
    if (m_rg_x$EN) m_rg_x <= `BSV_ASSIGNMENT_DELAY m_rg_x$D_IN;
    if (m_rg_xy$EN) m_rg_xy <= `BSV_ASSIGNMENT_DELAY m_rg_xy$D_IN;
    if (m_rg_y$EN) m_rg_y <= `BSV_ASSIGNMENT_DELAY m_rg_y$D_IN;
  end
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else 
  initial
  begin
    m_rg_isNeg = 1'h0;
    m_rg_signed = 1'h0;
    m_rg_state = 2'h2;
    m_rg_x = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    m_rg_xy = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    m_rg_y = 64'hAAAAAAAAAAAAAAAA;
  end
  `endif 
endmodule