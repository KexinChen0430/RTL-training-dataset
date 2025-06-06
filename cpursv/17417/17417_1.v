
module v7_emac_controller(input  glbl_rst,
                          input  clkin200,
                          output phy_resetn,
                          input  gtrefclk_p,
                          input  gtrefclk_n,
                          output txp,
                          output txn,
                          input  rxp,
                          input  rxn,
                          output synchronization_done,
                          output linkup,
                          input  mdio_i,
                          output mdio_o,
                          output mdio_t,
                          output mdc,
                          output rx_fifo_clk,
                          output rx_fifo_rstn,
                          output [7:0] rx_axis_fifo_tdata,
                          output rx_axis_fifo_tvalid,
                          input  rx_axis_fifo_tready,
                          output rx_axis_fifo_tlast,
                          output tx_fifo_clk,
                          output tx_fifo_rstn,
                          input  [7:0] tx_axis_fifo_tdata,
                          input  tx_axis_fifo_tvalid,
                          output tx_axis_fifo_tready,
                          input  tx_axis_fifo_tlast,
                          input  loop_back_en,
                          output o_tx_mac_count);


endmodule

