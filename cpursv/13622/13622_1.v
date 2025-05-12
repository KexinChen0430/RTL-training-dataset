
module altpcie_reconfig_4sgx(logical_channel_address,offset_cancellation_reset,read,
                             reconfig_clk,reconfig_fromgxb,rx_eqctrl,rx_eqdcgain,
                             tx_preemp_0t,tx_preemp_1t,tx_preemp_2t,tx_vodctrl,write_all,
                             busy,data_valid,reconfig_togxb,rx_eqctrl_out,rx_eqdcgain_out,
                             tx_preemp_0t_out,tx_preemp_1t_out,tx_preemp_2t_out,
                             tx_vodctrl_out);

  input  [2:0] logical_channel_address;
  input  offset_cancellation_reset;
  input  read;
  input  reconfig_clk;
  input  [33:0] reconfig_fromgxb;
  input  [3:0] rx_eqctrl;
  input  [2:0] rx_eqdcgain;
  input  [4:0] tx_preemp_0t;
  input  [4:0] tx_preemp_1t;
  input  [4:0] tx_preemp_2t;
  input  [2:0] tx_vodctrl;
  input  write_all;
  output busy;
  output data_valid;
  output [3:0] reconfig_togxb;
  output [3:0] rx_eqctrl_out;
  output [2:0] rx_eqdcgain_out;
  output [4:0] tx_preemp_0t_out;
  output [4:0] tx_preemp_1t_out;
  output [4:0] tx_preemp_2t_out;
  output [2:0] tx_vodctrl_out;
  tri0 offset_cancellation_reset;
  wire [3:0] sub_wire0;
  wire [4:0] sub_wire1;
  wire [2:0] sub_wire2;
  wire sub_wire3;
  wire [4:0] sub_wire4;
  wire sub_wire5;
  wire [3:0] sub_wire6;
  wire [4:0] sub_wire7;
  wire [2:0] sub_wire8;
  wire [2:0]  sub_wire9 = 3'h0;
  wire [3:0]  reconfig_togxb = sub_wire0[3:0];
  wire [4:0]  tx_preemp_2t_out = sub_wire1[4:0];
  wire [2:0]  tx_vodctrl_out = sub_wire2[2:0];
  wire  data_valid = sub_wire3;
  wire [4:0]  tx_preemp_0t_out = sub_wire4[4:0];
  wire  busy = sub_wire5;
  wire [3:0]  rx_eqctrl_out = sub_wire6[3:0];
  wire [4:0]  tx_preemp_1t_out = sub_wire7[4:0];
  wire [2:0]  rx_eqdcgain_out = sub_wire8[2:0];

  altpcie_reconfig_4sgx_alt2gxb_reconfig_squ1 altpcie_reconfig_4sgx_alt2gxb_reconfig_squ1_component(.logical_channel_address(logical_channel_address),
                                                                                                    .tx_preemp_1t(tx_preemp_1t),.reconfig_fromgxb(reconfig_fromgxb),
                                                                                                    .tx_preemp_2t(tx_preemp_2t),.tx_vodctrl(tx_vodctrl),
                                                                                                    .reconfig_clk(reconfig_clk),.tx_preemp_0t(tx_preemp_0t),
                                                                                                    .write_all(write_all),.read(read),
                                                                                                    .reconfig_mode_sel(sub_wire9),.rx_eqctrl(rx_eqctrl),
                                                                                                    .offset_cancellation_reset(offset_cancellation_reset),.rx_eqdcgain(rx_eqdcgain),
                                                                                                    .reconfig_togxb(sub_wire0),.tx_preemp_2t_out(sub_wire1),
                                                                                                    .tx_vodctrl_out(sub_wire2),.data_valid(sub_wire3),
                                                                                                    .tx_preemp_0t_out(sub_wire4),.busy(sub_wire5),
                                                                                                    .rx_eqctrl_out(sub_wire6),.tx_preemp_1t_out(sub_wire7),
                                                                                                    .rx_eqdcgain_out(sub_wire8));
endmodule

