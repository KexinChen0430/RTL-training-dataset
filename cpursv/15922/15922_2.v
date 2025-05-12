
module uart_2  #(parameter  tam_data = 11, read_bit = 4)
  (input  clk,
   input  clk_Hz,
   input  tx_Hz,
   input  reset,
   output tx_busy,
   output rx_busy,
   input  rx_channel,
   output tx_channel,
   input  tx_data,
   output rx_data,
   output rx_clk,
   output tx_clk);

  wire [28:0] clk_Hz;
  wire [28:0] tx_Hz;
  reg  [28:0]  cont_tx_Hz = 0;
  wire [28:0]  dInc = cont_tx_Hz[28] ? tx_Hz : (tx_Hz-clk_Hz);
  wire [28:0]  dN = dInc+cont_tx_Hz;

  
  always @(posedge clk)
      begin
        cont_tx_Hz = dN;
      end
  assign tx_clk = cont_tx_Hz[28];
  assign rx_clk = clk;
  reg  [3:0]  cnt_data = 4'd0;

  wire [tam_data+(0-1):0] tx_data;

  reg  tx_busy;

  reg   tx_channel = 0;

  
  always @(posedge tx_clk)
      begin
        if (reset) 
          begin
            cnt_data <= 4'd0;
            tx_busy <= 0;
          end
          
        if (cnt_data == 0) 
          begin
            tx_channel <= tx_data[cnt_data];
            tx_busy <= 1;
            cnt_data <= 1+cnt_data;
          end
          
        if ((cnt_data > 0) && tx_busy && (cnt_data < tam_data)) 
          begin
            tx_channel <= tx_data[cnt_data];
            cnt_data <= 1+cnt_data;
          end
          
        if (cnt_data == tam_data) 
          begin
            tx_channel <= 1;
            tx_busy <= 0;
          end
          
      end
  reg  [3:0]  cnt_read = 4'd0;

  reg  [3:0]  cnt_rx = 4'd0;

  reg  [tam_data+(0-1):0]  rx_data = 0;

  reg  rx_busy;

  
  always @(posedge rx_clk)
      begin
        if (reset) 
          begin
            cnt_read <= 0;
            rx_busy <= 0;
            cnt_rx <= 0;
          end
        else 
          begin
            if ((cnt_rx < read_bit) && (cnt_read < tam_data)) 
              begin
                rx_busy <= 1;
                cnt_rx <= 1+cnt_rx;
              end
              
            if (rx_busy && (cnt_rx == read_bit)) 
              begin
                rx_data = {rx_channel,rx_data[10:1]};
                cnt_rx <= 1+cnt_rx;
              end
              
            if ((cnt_rx <= (read_bit+(read_bit+(0-1)))) && rx_busy && 
                (cnt_rx > read_bit)) 
              begin
                if (rx_busy && (cnt_rx == (read_bit+(read_bit+(0-1))))) 
                  begin
                    cnt_read <= 1+cnt_read;
                    cnt_rx <= 0;
                  end
                else 
                  begin
                    cnt_rx <= 1+cnt_rx;
                  end
              end
              
            if (rx_busy && (cnt_read == tam_data)) 
              begin
                rx_busy <= 0;
              end
              
          end
      end
endmodule

