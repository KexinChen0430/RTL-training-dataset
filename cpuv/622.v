module OBUFDS_DPHY #(
  `ifdef XIL_TIMING
    parameter LOC = "UNPLACED",
  `endif
  parameter IOSTANDARD = "DEFAULT"
)(
  output O,    
  output OB,   
  input HSTX_I,    
  input HSTX_T,    
  input LPTX_I_N,  
  input LPTX_I_P,  
  input LPTX_T     
);
localparam MODULE_NAME = "OBUFDS_DPHY";
localparam IOSTANDARD_DEFAULT = 0; 
reg trig_attr = 1'b0; 
`ifdef XIL_DR
  `include "OBUFDS_DPHY_dr.v"
`else
  localparam [56:1] IOSTANDARD_REG = IOSTANDARD;
`endif
wire IOSTANDARD_BIN;
`ifdef XIL_ATTR_TEST
  reg attr_test = 1'b1; 
`else
  reg attr_test = 1'b0; 
`endif
reg attr_err = 1'b0; 
tri0 glblGSR = glbl.GSR;
reg OB_out; 
reg O_out;  
wire HSTX_I_in = HSTX_I;
wire HSTX_T_in = HSTX_T;
wire LPTX_I_N_in = LPTX_I_N;
wire LPTX_I_P_in = LPTX_I_P;
wire LPTX_T_in = LPTX_T;
reg hs_mode = 1'b1;
assign (strong1,strong0) O = (hs_mode === 1'b0) ? O_out : 1'bz;
assign (strong1, strong0) OB = (hs_mode === 1'b0) ? OB_out : 1'bz;
assign (supply1,supply0) O = (hs_mode === 1'b1) ? O_out : 1'bz;
assign (supply1,supply0) OB = (hs_mode === 1'b1) ? OB_out : 1'bz;
assign IOSTANDARD_BIN =
  (IOSTANDARD_REG == "DEFAULT") ? IOSTANDARD_DEFAULT :
   IOSTANDARD_DEFAULT;
always @ (LPTX_T_in or HSTX_T_in or LPTX_I_P_in or LPTX_I_N_in or HSTX_I_in) begin
  if (LPTX_T_in === 1'b0) begin
    O_out   <= LPTX_I_P_in;
    OB_out  <= LPTX_I_N_in;
    hs_mode <= 1'b0;
  end else if (LPTX_T_in === 1'b1 && HSTX_T_in === 1'b0) begin
    O_out   <= HSTX_I_in;
    OB_out  <= ~HSTX_I_in;
    hs_mode <= 1'b1;
  end else begin
    O_out   <= 1'bz;
    OB_out  <= 1'bz;
    hs_mode <= 1'bx;
  end
end
specify
  (HSTX_I => O) = (0:0:0, 0:0:0);
  (HSTX_I => OB) = (0:0:0, 0:0:0);
  (HSTX_T => O) = (0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
  (HSTX_T => OB) = (0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
  (LPTX_I_N => OB) = (0:0:0, 0:0:0);
  (LPTX_I_P => O) = (0:0:0, 0:0:0);
  (LPTX_T => O) = (0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
  (LPTX_T => OB) = (0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
  specparam PATHPULSE$ = 0;
endspecify
endmodule