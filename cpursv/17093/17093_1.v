
module nios_system(alu_a_export,alu_b_export,alu_carry_out_export,
                   alu_control_export,alu_negative_export,alu_out_export,
                   alu_overflow_export,alu_zero_export,clk_clk,hex_0_export,
                   hex_1_export,hex_2_export,hex_3_export,hex_4_export,
                   hex_5_export,leds_export,regfile_data_export,
                   regfile_r1sel_export,regfile_r2sel_export,regfile_reg1_export,
                   regfile_reg2_export,regfile_we_export,regfile_wsel_export,
                   reset_reset_n,sram_addr_export,sram_cs_export,
                   sram_data_in_export,sram_oe_export,sram_read_write_export,
                   switches_export,keys_export);

  output [31:0] alu_a_export;
  output [31:0] alu_b_export;
  input  alu_carry_out_export;
  output [2:0] alu_control_export;
  input  alu_negative_export;
  input  [31:0] alu_out_export;
  input  alu_overflow_export;
  input  alu_zero_export;
  input  clk_clk;
  output [3:0] hex_0_export;
  output [3:0] hex_1_export;
  output [3:0] hex_2_export;
  output [3:0] hex_3_export;
  output [3:0] hex_4_export;
  output [3:0] hex_5_export;
  output [9:0] leds_export;
  output [31:0] regfile_data_export;
  output [5:0] regfile_r1sel_export;
  output [5:0] regfile_r2sel_export;
  input  [31:0] regfile_reg1_export;
  input  [31:0] regfile_reg2_export;
  output regfile_we_export;
  output [5:0] regfile_wsel_export;
  input  reset_reset_n;
  output [10:0] sram_addr_export;
  output sram_cs_export;
  inout  [15:0] sram_data_in_export;
  output sram_oe_export;
  output sram_read_write_export;
  input  [9:0] switches_export;
  input  [3:0] keys_export;


endmodule

