
module ulight_fifo(auto_start_external_connection_export,clk_clk,
                   clock_sel_external_connection_export,
                   counter_rx_fifo_external_connection_export,
                   counter_tx_fifo_external_connection_export,
                   data_flag_rx_external_connection_export,
                   data_info_external_connection_export,
                   data_read_en_rx_external_connection_export,
                   fifo_empty_rx_status_external_connection_export,
                   fifo_empty_tx_status_external_connection_export,
                   fifo_full_rx_status_external_connection_export,
                   fifo_full_tx_status_external_connection_export,
                   fsm_info_external_connection_export,
                   led_pio_test_external_connection_export,
                   link_disable_external_connection_export,
                   link_start_external_connection_export,memory_mem_a,
                   memory_mem_ba,memory_mem_ck,memory_mem_ck_n,memory_mem_cke,
                   memory_mem_cs_n,memory_mem_ras_n,memory_mem_cas_n,
                   memory_mem_we_n,memory_mem_reset_n,memory_mem_dq,
                   memory_mem_dqs,memory_mem_dqs_n,memory_mem_odt,memory_mem_dm,
                   memory_oct_rzqin,pll_0_locked_export,pll_0_outclk0_clk,
                   reset_reset_n,timecode_ready_rx_external_connection_export,
                   timecode_rx_external_connection_export,
                   timecode_tx_data_external_connection_export,
                   timecode_tx_enable_external_connection_export,
                   timecode_tx_ready_external_connection_export,
                   write_data_fifo_tx_external_connection_export,
                   write_en_tx_external_connection_export);


endmodule

