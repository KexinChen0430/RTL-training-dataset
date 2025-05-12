module finalproject_cpu_nios2_oci_fifo_cnt_inc (
  input empty,
  input ge2_free,
  input ge3_free,
  input [1:0] input_tm_cnt,
  output [4:0] fifo_cnt_inc
);