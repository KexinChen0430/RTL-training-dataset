module qlal3_interrupt_controller_cell (
  input         af_fpga_int_en,       
  input  [ 7:0] int_i,               
  output        int_o,               
  input  [ 1:0] reg_addr_int,        
  input         reg_clk_int,         
  input         reg_clk_intS,        
  output [ 7:0] reg_rd_data_int,     
  input         reg_rd_en_int,       
  input  [ 7:0] reg_wr_data_int,     
  input         reg_wr_en_int        
);
endmodule 