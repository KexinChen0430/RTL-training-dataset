
module altgx_reconfig(reconfig_clk,reconfig_fromgxb,busy,error,reconfig_togxb);

  input  reconfig_clk;
  input  [16:0] reconfig_fromgxb;
  output busy;
  output error;
  output [3:0] reconfig_togxb;
  wire sub_wire0;
  wire sub_wire1;
  wire [3:0] sub_wire2;
  wire [2:0]  sub_wire3 = 3'h0;
  wire  busy = sub_wire0;
  wire  error = sub_wire1;
  wire [3:0]  reconfig_togxb = sub_wire2[3:0];

  altgx_reconfig_alt2gxb_reconfig_t331 altgx_reconfig_alt2gxb_reconfig_t331_component(.reconfig_clk(reconfig_clk),
                                                                                      .reconfig_fromgxb(reconfig_fromgxb),.reconfig_mode_sel(sub_wire3),
                                                                                      .busy(sub_wire0),.error(sub_wire1),
                                                                                      .reconfig_togxb(sub_wire2));
endmodule

