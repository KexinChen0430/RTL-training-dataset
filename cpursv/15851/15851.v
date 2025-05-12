
module qlal3_ram_4096x17_cell(input  [11:0] RAM_P0_ADDR,
                              input  RAM_P0_CLK,
                              input  RAM_P0_CLKS,
                              input  [1:0] RAM_P0_WR_BE,
                              input  [16:0] RAM_P0_WR_DATA,
                              input  RAM_P0_WR_EN,
                              input  [11:0] RAM_P1_ADDR,
                              input  RAM_P1_CLK,
                              input  RAM_P1_CLKS,
                              output [16:0] RAM_P1_RD_DATA,
                              input  RAM_P1_RD_EN,
                              input  RAM_P1_mux,
                              input  RAM_RME_af,
                              input  [3:0] RAM_RM_af,
                              input  RAM_TEST1_af,
                              output RAM_fifo_almost_empty,
                              output RAM_fifo_almost_full,
                              output [3:0] RAM_fifo_empty_flag,
                              input  RAM_fifo_en,
                              output [3:0] RAM_fifo_full_flag);


endmodule

