module Cfu (
  input               cmd_valid,
  output              cmd_ready,
  input      [9:0]    cmd_payload_function_id,
  input      [31:0]   cmd_payload_inputs_0,
  input      [31:0]   cmd_payload_inputs_1,
  output              rsp_valid,
  input               rsp_ready,
  output     [31:0]   rsp_payload_outputs_0,
  input               reset,
  input               clk,
  output    [13:0]    port0_addr,
  output    [13:0]    port1_addr,
  output    [13:0]    port2_addr,
  output    [13:0]    port3_addr,
  input     [31:0]    port0_din,
  input     [31:0]    port1_din,
  input     [31:0]    port2_din,
  input     [31:0]    port3_din,
);
  reg cmd_valid_delay;
  always @(posedge clk) if (rsp_ready) cmd_valid_delay <= cmd_valid;
  assign rsp_valid = cmd_valid_delay;
  assign cmd_ready = rsp_ready;
  assign port0_addr = cmd_payload_inputs_1;
  assign port1_addr = cmd_payload_inputs_1;
  assign port2_addr = cmd_payload_inputs_1;
  assign port3_addr = cmd_payload_inputs_1;
  reg [1:0] bank_sel;
  always @(posedge clk) if (rsp_ready) bank_sel <= cmd_payload_inputs_0;
  assign rsp_payload_outputs_0 = bank_sel[1] ? (bank_sel[0] ? port3_din : port2_din)
                                             : (bank_sel[0] ? port1_din : port0_din);
endmodule