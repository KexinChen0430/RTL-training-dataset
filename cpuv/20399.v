module autoinst_vertrees_slv
  (
   i2c_mst_data, i2c_read, i2c_slv_scl_out, i2c_slv_sda_out, i2c_spc_scl_state, i2c_start,
   i2c_strobe, slv_bit_st, slv_put, i2c_spc_scl_fall, i2c_spc_sda_state, i2c_spc_start,
   i2c_spc_stop,
   ck_ref, i2c_slv_data, i2c_slv_scl_in, i2c_slv_sda_in, r_i2c_spc_scl_low, rpt_hold, rpt_sda,
   rst_ref, test_mode
   );
   input        ck_ref; 
   input [7:0]  i2c_slv_data; 
   input        i2c_slv_scl_in; 
   input        i2c_slv_sda_in; 
   input [4:0]  r_i2c_spc_scl_low; 
   input        rpt_hold; 
   input        rpt_sda; 
   input        rst_ref; 
   input        test_mode; 
   output [7:0] i2c_mst_data; 
   output       i2c_read; 
   output       i2c_slv_scl_out; 
   output       i2c_slv_sda_out; 
   output       i2c_spc_scl_state; 
   output       i2c_start; 
   output       i2c_strobe; 
   output       slv_bit_st; 
   output       slv_put; 
   output       i2c_spc_scl_fall; 
   output       i2c_spc_sda_state; 
   output       i2c_spc_start; 
   output       i2c_spc_stop; 
endmodule