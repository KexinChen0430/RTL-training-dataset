
module qlal3_i2c_cell(input  arst,
                      input  arstS,
                      output wb_ack,
                      input  [2:0] wb_adr,
                      input  wb_clk,
                      input  wb_clkS,
                      input  wb_cyc,
                      input  [7:0] wb_dat_i,
                      output [7:0] wb_dat_o,
                      output wb_inta,
                      input  wb_rst,
                      input  wb_rstS,
                      input  wb_stb,
                      input  wb_we,
                      input  al_clr_i,
                      output al_o,
                      input  al_stick_en_i,
                      output i2c_busy_o,
                      input  rxack_clr_i,
                      output rxack_o,
                      input  rxack_stick_en_i,
                      output tip_o,
                      output DrivingI2cBusOut,
                      input  SCL_i,
                      output SCL_o,
                      output SCL_oen,
                      input  SDA_i,
                      output SDA_o,
                      output SDA_oen);


endmodule

