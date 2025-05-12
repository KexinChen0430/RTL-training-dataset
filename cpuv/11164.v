module ad_dds_cordic_pipe#(
  parameter P_DW = 16,
  parameter D_DW = 16,
  parameter DELAY_DW = 1,
  parameter SHIFT = 0) (
  input                          clk,
  (* keep = "TRUE" *) input                          dir,
  (* keep = "TRUE" *) input             [  D_DW-1:0] dataa_x,
  (* keep = "TRUE" *) input             [  D_DW-1:0] dataa_y,
  (* keep = "TRUE" *) input             [  P_DW-1:0] dataa_z,
  (* keep = "TRUE" *) input             [  P_DW-1:0] datab_z,
  (* keep = "TRUE" *) output reg        [  D_DW-1:0] result_x,
  (* keep = "TRUE" *) output reg        [  D_DW-1:0] result_y,
  (* keep = "TRUE" *) output reg        [  P_DW-1:0] result_z,
  input             [DELAY_DW:1] data_delay_in,
  output            [DELAY_DW:1] data_delay_out);
  reg   [DELAY_DW:1] data_delay = 'd0;
  wire  [  D_DW-1:0]  sgn_shift_x;
  wire  [  D_DW-1:0]  sgn_shift_y;
  wire                dir_inv = ~dir;
  assign sgn_shift_x = {{SHIFT{dataa_x[D_DW-1]}}, dataa_x[D_DW-1:SHIFT]};
  assign sgn_shift_y = {{SHIFT{dataa_y[D_DW-1]}}, dataa_y[D_DW-1:SHIFT]};
  always @(posedge clk) begin
    result_x <= dataa_x + ({D_DW{dir_inv}} ^ sgn_shift_y) + dir_inv;
    result_y <= dataa_y + ({D_DW{dir}}     ^ sgn_shift_x) + dir;
    result_z <= dataa_z + ({P_DW{dir_inv}} ^     datab_z) + dir_inv;
  end
  generate
    if (DELAY_DW > 1) begin
      always @(posedge clk) begin
        data_delay <= data_delay_in;
      end
    end
  endgenerate
  assign data_delay_out = data_delay;
endmodule