module uart_regs ( 
                    address, 
                    break_detect, 
                    chipselect, 
                    clk, 
                    clk_en, 
                    framing_error, 
                    parity_error, 
                    read_n, 
                    reset_n, 
                    rx_char_ready, 
                    rx_data, 
                    rx_overrun, 
                    tx_overrun, 
                    tx_ready, 
                    tx_shift_empty, 
                    write_n, 
                    writedata, 
                    baud_divisor, 
                    dataavailable, 
                    do_force_break, 
                    irq, 
                    readdata, 
                    readyfordata, 
                    rx_rd_strobe, 
                    status_wr_strobe, 
                    tx_data, 
                    tx_wr_strobe 
                 );
  output  [  8: 0] baud_divisor; 
  output           dataavailable; 
  output           do_force_break; 
  output           irq; 
  output  [ 15: 0] readdata; 
  output           readyfordata; 
  output           rx_rd_strobe; 
  output           status_wr_strobe; 
  output  [  7: 0] tx_data; 
  output           tx_wr_strobe; 
  input   [  2: 0] address; 
  input            break_detect; 
  input            chipselect; 
  input            clk; 
  input            clk_en; 
  input            framing_error; 
  input            parity_error; 
  input            read_n; 
  input            reset_n; 
  input            rx_char_ready; 
  input   [  7: 0] rx_data; 
  input            rx_overrun; 
  input            tx_overrun; 
  input            tx_ready; 
  input            tx_shift_empty; 
  input            write_n; 
  input   [ 15: 0] writedata; 
  wire             any_error; 
  wire    [  8: 0] baud_divisor; 
  reg     [  9: 0] control_reg; 
  wire             control_wr_strobe; 
  wire             cts_status_bit; 
  reg              d1_rx_char_ready; 
  reg              d1_tx_ready; 
  wire             dataavailable; 
  wire             dcts_status_bit; 
  reg              delayed_unxtx_readyxx4; 
  wire    [  8: 0] divisor_constant; 
  wire             do_force_break; 
  wire             do_write_char; 
  wire             eop_status_bit; 
  wire             ie_any_error; 
  wire             ie_break_detect; 
  wire             ie_framing_error; 
  wire             ie_parity_error; 
  wire             ie_rx_char_ready; 
  wire             ie_rx_overrun; 
  wire             ie_tx_overrun; 
  wire             ie_tx_ready; 
  wire             ie_tx_shift_empty; 
  reg              irq; 
  wire             qualified_irq; 
  reg     [ 15: 0] readdata; 
  wire             readyfordata; 
  wire             rx_rd_strobe; 
  wire    [ 15: 0] selected_read_data; 
  wire    [ 12: 0] status_reg; 
  wire             status_wr_strobe; 
  reg     [  7: 0] tx_data; 
  wire             tx_wr_strobe; 
endmodule