module uart_drv (clk, nreset, rx, tx,
                 rxdata, rxrdy, rxerr,
                 txdata, txrdy, txack);
parameter clk_period_ns = `CLKPERIOD50/`NANOSECOND; 
parameter baud_rate     = `TEST_BAUDRATE;           
parameter stop_bits     = 1;                         
parameter data_bits     = 8;                         
parameter parity_bit    = 0;                         
parameter parity_odd    = 0;                         
parameter clks_per_bit = (`MILLISECOND/clk_period_ns)/baud_rate;
input          clk;          
input          nreset;       
input          rx;           
output         tx;           
input    [7:0] txdata;       
input          txrdy;        
output         txack;        
output   [7:0] rxdata;       
output         rxrdy;        
output         rxerr;        
reg      [7:0] rxdata;       
reg            rxrdy;        
reg            txack;        
reg            txack_last;   
reg      [7:0] rx_shift;     
reg            last_rx;      
reg            rxerr;        
reg            last_txrdy;   
reg      [7:0] txdata_reg;   
reg            txdata_par_reg; 
reg      [3:0] txidx;        
reg      [3:0] rx_bit_count; 
integer        rx_dly_count; 
reg      [3:0] tx_bit_count; 
integer        tx_dly_count; 
wire     [7:0] next_rx_shift = {rx, rx_shift[7:1]}; 
wire    [11:0] tx_data       = {2'b11, parity_bit ? {txdata_par_reg, txdata_reg} : {1'b1, txdata_reg}, 1'b0};
assign      tx               = tx_data[txidx]; 
always @(posedge clk or negedge nreset)
begin
  if (nreset == 1'b0) 
  begin
    rx_bit_count          <= 4'h0;
    rx_dly_count          <= 4'h0;
    last_rx               <= 1'b1;
    rxrdy                 <= 1'b0;
    rxerr                 <= 1'b0;
  end
  else 
  begin
    rxrdy                 <= 1'b0;
    last_rx               <= rx;
    rx_dly_count          <= rx_dly_count - ((rx_dly_count != 4'h0) ? 1 : 0);
    if (rx == 1'b0 && last_rx == 1'b1 && rx_bit_count == 4'h0 && rx_dly_count == 4'h0)
    begin
       rx_bit_count       <= data_bits + parity_bit;
       rx_dly_count       <= clks_per_bit + clks_per_bit/2;
    end
    if (rx_dly_count == 4'h1)
    begin
      if (rx_bit_count != 0)
      begin
        rx_bit_count      <= rx_bit_count - 4'h1;
        rx_dly_count      <= clks_per_bit + 1;
        rx_shift          <= next_rx_shift;
        if (rx_bit_count == parity_bit+1)
        begin
          rxrdy           <= 1'b1;
          rxdata          <= next_rx_shift;
        end
        if (parity_bit == 1 && rx_bit_count == 4'h1)
        begin
          if (^rx_shift[7:0] != (parity_odd ? 1'b1 : 1'b0))
          begin
            $display("UART: ***ERROR parity failed");
            rxerr         <= 1'b1;
          end
        end
      end
    end
  end
end
always @(posedge clk or negedge nreset)
begin
  if (nreset == 1'b0) 
  begin
    txack                 <= 1'b0;
    txack_last            <= 1'b0;
    tx_bit_count          <= 4'h0;
    tx_dly_count          <= 4'h0;
    txidx                 <= 4'd11; 
  end
  else 
  begin
    last_txrdy            <= txrdy;
    txack                 <= 1'b0;
    txack_last            <= txack;
    tx_dly_count          <= tx_dly_count - ((tx_dly_count != 0) ? 1 : 0);
    if ((txrdy == 1'b1 && last_txrdy == 1'b0) || (txrdy == 1'b1 && txack_last == 1'b1))
    begin
      txdata_reg          <= txdata;
      txdata_par_reg      <= (^txdata) ^ (parity_odd ? 1'b0 : 1'b1);
      tx_bit_count        <= 1 + data_bits + parity_bit + stop_bits;
      tx_dly_count        <= clks_per_bit;
      txidx               <= 0;
    end
    if (tx_bit_count != 4'h0 && tx_dly_count == 4'h1)
    begin
      tx_bit_count        <= tx_bit_count - 4'h1;
      txidx               <= txidx        + 4'h1;
      tx_dly_count        <= clks_per_bit;
    end
    if (tx_bit_count == 4'h1 && tx_dly_count == 1)
    begin
      txack               <= 1'b1;
    end
  end
end
endmodule