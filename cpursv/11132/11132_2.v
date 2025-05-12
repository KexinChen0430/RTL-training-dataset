
module wasca_uart_0_regs(input  [2:0] address,
                         input  break_detect,
                         input  chipselect,
                         input  clk,
                         input  clk_en,
                         input  framing_error,
                         input  parity_error,
                         input  read_n,
                         input  reset_n,
                         input  rx_char_ready,
                         input  [7:0] rx_data,
                         input  rx_overrun,
                         input  tx_overrun,
                         input  tx_ready,
                         input  tx_shift_empty,
                         input  write_n,
                         input  [15:0] writedata,
                         output [15:0] baud_divisor,
                         output dataavailable,
                         output do_force_break,
                         output irq,
                         output [15:0] readdata,
                         output readyfordata,
                         output rx_rd_strobe,
                         output status_wr_strobe,
                         output [7:0] tx_data,
                         output tx_wr_strobe);

  wire any_error;
  reg  [15:0] baud_divisor;
  reg  [9:0] control_reg;
  wire control_wr_strobe;
  wire cts_status_bit;
  reg  d1_rx_char_ready;
  reg  d1_tx_ready;
  wire dataavailable;
  wire dcts_status_bit;
  reg  delayed_unxtx_readyxx4;
  wire [15:0] divisor_constant;
  wire divisor_wr_strobe;
  wire do_force_break;
  wire do_write_char;
  wire eop_status_bit;
  wire ie_any_error;
  wire ie_break_detect;
  wire ie_framing_error;
  wire ie_parity_error;
  wire ie_rx_char_ready;
  wire ie_rx_overrun;
  wire ie_tx_overrun;
  wire ie_tx_ready;
  wire ie_tx_shift_empty;
  reg  irq;
  wire qualified_irq;
  reg  [15:0] readdata;
  wire readyfordata;
  wire rx_rd_strobe;
  wire [15:0] selected_read_data;
  wire [12:0] status_reg;
  wire status_wr_strobe;
  reg  [7:0] tx_data;
  wire tx_wr_strobe;

  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) readdata <= 0;
        else if (clk_en) readdata <= selected_read_data;
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) irq <= 0;
        else if (clk_en) irq <= qualified_irq;
          
      end
  assign rx_rd_strobe = chipselect && (address == 3'd0) && ~read_n;
  assign tx_wr_strobe = ~write_n && (chipselect && (address == 3'd1));
  assign status_wr_strobe = (address == 3'd2) && (chipselect && ~write_n);
  assign control_wr_strobe = chipselect && ~write_n && (address == 3'd3);
  assign divisor_wr_strobe = chipselect && ~write_n && (address == 3'd4);
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) tx_data <= 0;
        else if (tx_wr_strobe) tx_data <= writedata[7:0];
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) control_reg <= 0;
        else if (control_wr_strobe) control_reg <= writedata[9:0];
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) baud_divisor <= divisor_constant;
        else if (divisor_wr_strobe) baud_divisor <= writedata[15:0];
          
      end
  assign cts_status_bit = 0;
  assign dcts_status_bit = 0;
  assign {do_force_break,ie_any_error,ie_rx_char_ready,ie_tx_ready,ie_tx_shift_empty,ie_tx_overrun,ie_rx_overrun,ie_break_detect,ie_framing_error,ie_parity_error} = control_reg;
  assign any_error = parity_error || 
                     (break_detect || 
(framing_error || (tx_overrun || rx_overrun)));
  assign status_reg = {eop_status_bit,cts_status_bit,dcts_status_bit,1'b0,any_error,rx_char_ready,tx_ready,tx_shift_empty,tx_overrun,rx_overrun,break_detect,framing_error,parity_error};
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) d1_rx_char_ready <= 0;
        else if (clk_en) d1_rx_char_ready <= rx_char_ready;
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) d1_tx_ready <= 0;
        else if (clk_en) d1_tx_ready <= tx_ready;
          
      end
  assign dataavailable = d1_rx_char_ready;
  assign readyfordata = d1_tx_ready;
  assign eop_status_bit = 1'b0;
  assign selected_read_data = (({16{address == 3'd2}} & status_reg) | ((({16{address == 3'd1}} & (((rx_data | tx_data) & (rx_data | {16{address == 3'd1}})) & tx_data)) | (baud_divisor & {16{address == 3'd4}})) | ({16{address == 3'd0}} & (((rx_data | {16{address == 3'd1}}) & ({16{address == 3'd1}} | {16{address == 3'd0}})) & rx_data)))) | (control_reg & {16{address == 3'd3}});
  assign qualified_irq = 
(ie_tx_ready || 
(
(ie_rx_char_ready || 
(
(
(
(
(ie_rx_overrun || (ie_break_detect && break_detect)) && (rx_overrun || (ie_break_detect && break_detect))) || 
(ie_tx_shift_empty || 
((ie_tx_overrun && tx_overrun) || 
(ie_any_error && any_error)))) && 
(
(
(ie_rx_overrun || (ie_break_detect && break_detect)) && (rx_overrun || (ie_break_detect && break_detect))) || 
((ie_tx_overrun && tx_overrun) || 
((any_error || tx_shift_empty) && 
(ie_any_error || tx_shift_empty))))) || 
((parity_error && ie_parity_error) || framing_error))) && 
(
(
(
((any_error || tx_shift_empty) && 
(ie_any_error || tx_shift_empty) && 
((ie_tx_shift_empty || ie_any_error) && 
(any_error || ie_tx_shift_empty))) || 
(tx_overrun && 
(ie_tx_overrun || 
((ie_tx_shift_empty || ie_any_error) && 
(any_error || ie_tx_shift_empty))) && 
(ie_tx_overrun || 
((any_error || tx_shift_empty) && 
(ie_any_error || tx_shift_empty)))) || 
(ie_rx_overrun || (ie_break_detect && break_detect)) || ie_framing_error) && 
(
(
(ie_tx_shift_empty || 
((ie_tx_overrun && tx_overrun) || 
(ie_any_error && any_error)) || rx_overrun) && 
((ie_tx_overrun && tx_overrun) || 
((any_error || tx_shift_empty) && 
(ie_any_error || tx_shift_empty)) || rx_overrun)) || (ie_break_detect && break_detect) || ie_framing_error)) || (parity_error && ie_parity_error) || ie_rx_char_ready))) && 
                         (
(
((parity_error && ie_parity_error) || framing_error) && 
((parity_error && ie_parity_error) || ie_framing_error)) || rx_char_ready || 
(
(
(
(ie_rx_overrun || (ie_break_detect && break_detect)) && (rx_overrun || (ie_break_detect && break_detect))) || 
(ie_tx_shift_empty || 
((ie_tx_overrun && tx_overrun) || 
(ie_any_error && any_error)))) && 
(
(
(ie_rx_overrun || (ie_break_detect && break_detect)) && (rx_overrun || (ie_break_detect && break_detect))) || 
((ie_tx_overrun && tx_overrun) || 
((any_error || tx_shift_empty) && 
(ie_any_error || tx_shift_empty))))) || ie_tx_ready) && 
                         (
(tx_ready || 
(
(
((parity_error && ie_parity_error) || framing_error) && 
((parity_error && ie_parity_error) || ie_framing_error)) || rx_char_ready || 
(
(
(
(ie_rx_overrun || (ie_break_detect && break_detect)) && (rx_overrun || (ie_break_detect && break_detect))) || 
(ie_tx_shift_empty || 
((ie_tx_overrun && tx_overrun) || 
(ie_any_error && any_error)))) && 
(
(
(ie_rx_overrun || (ie_break_detect && break_detect)) && (rx_overrun || (ie_break_detect && break_detect))) || 
((ie_tx_overrun && tx_overrun) || 
((any_error || tx_shift_empty) && 
(ie_any_error || tx_shift_empty))))))) && 
(tx_ready || 
(
(ie_rx_char_ready || 
(
(
(
(
(ie_rx_overrun || (ie_break_detect && break_detect)) && (rx_overrun || (ie_break_detect && break_detect))) || 
(ie_tx_shift_empty || 
((ie_tx_overrun && tx_overrun) || 
(ie_any_error && any_error)))) && 
(
(
(ie_rx_overrun || (ie_break_detect && break_detect)) && (rx_overrun || (ie_break_detect && break_detect))) || 
((ie_tx_overrun && tx_overrun) || 
((any_error || tx_shift_empty) && 
(ie_any_error || tx_shift_empty))))) || 
((parity_error && ie_parity_error) || framing_error))) && 
(
(
(
((any_error || tx_shift_empty) && 
(ie_any_error || tx_shift_empty) && 
((ie_tx_shift_empty || ie_any_error) && 
(any_error || ie_tx_shift_empty))) || 
(tx_overrun && 
(ie_tx_overrun || 
((ie_tx_shift_empty || ie_any_error) && 
(any_error || ie_tx_shift_empty))) && 
(ie_tx_overrun || 
((any_error || tx_shift_empty) && 
(ie_any_error || tx_shift_empty)))) || 
(ie_rx_overrun || (ie_break_detect && break_detect)) || ie_framing_error) && 
(
(
(ie_tx_shift_empty || 
((ie_tx_overrun && tx_overrun) || 
(ie_any_error && any_error)) || rx_overrun) && 
((ie_tx_overrun && tx_overrun) || 
((any_error || tx_shift_empty) && 
(ie_any_error || tx_shift_empty)) || rx_overrun)) || (ie_break_detect && break_detect) || ie_framing_error)) || (parity_error && ie_parity_error) || ie_rx_char_ready))));
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) delayed_unxtx_readyxx4 <= 0;
        else if (clk_en) delayed_unxtx_readyxx4 <= tx_ready;
          
      end
  assign do_write_char = ~delayed_unxtx_readyxx4 & tx_ready;
  
  always @(posedge clk)
      begin
        if (do_write_char) 
          $write("%c",tx_data);
          
      end
  assign divisor_constant = 4;
endmodule

