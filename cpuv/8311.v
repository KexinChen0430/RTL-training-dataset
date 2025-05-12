module outputs
  wire [63 : 0] result_value;
  wire result_valid;
  reg m_rg_isNeg;
  wire m_rg_isNeg$D_IN, m_rg_isNeg$EN;
  reg m_rg_signed;
  wire m_rg_signed$D_IN, m_rg_signed$EN;
  reg [1 : 0] m_rg_state;
  wire [1 : 0] m_rg_state$D_IN;
  wire m_rg_state$EN;
  reg [63 : 0] m_rg_x;
  wire [63 : 0] m_rg_x$D_IN;
  wire m_rg_x$EN;
  reg [63 : 0] m_rg_xy;
  wire [63 : 0] m_rg_xy$D_IN;
  wire m_rg_xy$EN;
  reg [31 : 0] m_rg_y;
  wire [31 : 0] m_rg_y$D_IN;
  wire m_rg_y$EN;
  wire CAN_FIRE_RL_m_compute,
       CAN_FIRE_put_args,
       WILL_FIRE_RL_m_compute,
       WILL_FIRE_put_args;
  wire [63 : 0] MUX_m_rg_x$write_1__VAL_1,
		MUX_m_rg_x$write_1__VAL_2,
		MUX_m_rg_xy$write_1__VAL_2;
  wire [31 : 0] MUX_m_rg_y$write_1__VAL_1, MUX_m_rg_y$write_1__VAL_2;
  wire [63 : 0] x__h239, x__h341, xy___1__h265;
  wire [31 : 0] _theResult___fst__h509,
		_theResult___fst__h512,
		_theResult___fst__h563,
		_theResult___fst__h566,
		_theResult___snd_fst__h558;
  wire IF_put_args_x_is_signed_THEN_put_args_x_BIT_31_ETC___d34;
  assign CAN_FIRE_put_args = 1'd1 ;
  assign WILL_FIRE_put_args = EN_put_args ;
  assign result_valid = m_rg_state == 2'd2 ;
  assign result_value = m_rg_xy ;
  assign CAN_FIRE_RL_m_compute = m_rg_state == 2'd1 ;
  assign WILL_FIRE_RL_m_compute = CAN_FIRE_RL_m_compute ;
  assign MUX_m_rg_x$write_1__VAL_1 = { 32'd0, _theResult___fst__h509 } ;
  assign MUX_m_rg_x$write_1__VAL_2 = { m_rg_x[62:0], 1'd0 } ;
  assign MUX_m_rg_xy$write_1__VAL_2 = (m_rg_y == 32'd0) ? x__h239 : x__h341 ;
  assign MUX_m_rg_y$write_1__VAL_1 =
	     (put_args_x_is_signed && put_args_y_is_signed) ?
	       _theResult___fst__h566 :
	       _theResult___snd_fst__h558 ;
  assign MUX_m_rg_y$write_1__VAL_2 = { 1'd0, m_rg_y[31:1] } ;
  assign m_rg_isNeg$D_IN =
	     (put_args_x_is_signed && put_args_y_is_signed) ?
	       put_args_x[31] != put_args_y[31] :
	       IF_put_args_x_is_signed_THEN_put_args_x_BIT_31_ETC___d34 ;
  assign m_rg_isNeg$EN = EN_put_args ;
  assign m_rg_signed$D_IN = 1'b0 ;
  assign m_rg_signed$EN = 1'b0 ;
  assign m_rg_state$D_IN = EN_put_args ? 2'd1 : 2'd2 ;
  assign m_rg_state$EN =
	     WILL_FIRE_RL_m_compute && m_rg_y == 32'd0 || EN_put_args ;
  assign m_rg_x$D_IN =
	     EN_put_args ?
	       MUX_m_rg_x$write_1__VAL_1 :
	       MUX_m_rg_x$write_1__VAL_2 ;
  assign m_rg_x$EN =
	     WILL_FIRE_RL_m_compute && m_rg_y != 32'd0 || EN_put_args ;
  assign m_rg_xy$D_IN = EN_put_args ? 64'd0 : MUX_m_rg_xy$write_1__VAL_2 ;
  assign m_rg_xy$EN =
	     WILL_FIRE_RL_m_compute && (m_rg_y == 32'd0 || m_rg_y[0]) ||
	     EN_put_args ;
  assign m_rg_y$D_IN =
	     EN_put_args ?
	       MUX_m_rg_y$write_1__VAL_1 :
	       MUX_m_rg_y$write_1__VAL_2 ;
  assign m_rg_y$EN =
	     WILL_FIRE_RL_m_compute && m_rg_y != 32'd0 || EN_put_args ;
  assign IF_put_args_x_is_signed_THEN_put_args_x_BIT_31_ETC___d34 =
	     put_args_x_is_signed ?
	       put_args_x[31] :
	       put_args_y_is_signed && put_args_y[31] ;
  assign _theResult___fst__h509 =
	     put_args_x_is_signed ? _theResult___fst__h512 : put_args_x ;
  assign _theResult___fst__h512 = put_args_x[31] ? -put_args_x : put_args_x ;
  assign _theResult___fst__h563 =
	     put_args_y_is_signed ? _theResult___fst__h566 : put_args_y ;
  assign _theResult___fst__h566 = put_args_y[31] ? -put_args_y : put_args_y ;
  assign _theResult___snd_fst__h558 =
	     put_args_x_is_signed ? put_args_y : _theResult___fst__h563 ;
  assign x__h239 = m_rg_isNeg ? xy___1__h265 : m_rg_xy ;
  assign x__h341 = m_rg_xy + m_rg_x ;
  assign xy___1__h265 = -m_rg_xy ;
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
    m_rg_x = 64'hAAAAAAAAAAAAAAAA;
    m_rg_xy = 64'hAAAAAAAAAAAAAAAA;
    m_rg_y = 32'hAAAAAAAA;
  end
  `endif 
endmodule