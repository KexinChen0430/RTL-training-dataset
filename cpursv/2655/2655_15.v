
module serial_txd(input  CLK_I,
                  input  RST_I,
                  input  [7:0] DAT_I,
                  output reg ACK_O,
                  input  CYC_I,
                  input  STB_I,
                  input  WE_I,
                  input  uart_rxd,
                  input  uart_rts,
                  output reg uart_txd,
                  output uart_cts);

  assign uart_cts = uart_rts;
  reg  [12:0] counter;

  
  always @(posedge CLK_I)
      begin
        if (RST_I == 1'b1) 
          begin
            ACK_O <= 1'b0;
            uart_txd <= 1'b1;
            counter <= 13'd0;
          end
        else if ((CYC_I == 1'b1) && 
                 ((WE_I == 1'b1) && (ACK_O == 1'b0) && (STB_I == 1'b1))) 
          begin
            if (counter < 13'd8191) counter <= counter+13'd1;
              
            if (counter < 434) uart_txd <= 1'b0;
            else if (counter < (1<<1*434)) uart_txd <= DAT_I[0];
            else if (counter < (3*434)) uart_txd <= DAT_I[1];
            else if (counter < (4*434)) uart_txd <= DAT_I[1<<1];
            else if (counter < (5*434)) uart_txd <= DAT_I[3];
            else if (counter < (434*6)) uart_txd <= DAT_I[4];
            else if (counter < (7*434)) uart_txd <= DAT_I[5];
            else if (counter < (8*434)) uart_txd <= DAT_I[6];
            else if (counter < (9*434)) uart_txd <= DAT_I[7];
            else if (counter < (434*10)) uart_txd <= 1'b1;
            else 
              begin
                uart_txd <= 1'b1;
                ACK_O <= 1'b1;
              end
          end
        else 
          begin
            ACK_O <= 1'b0;
            uart_txd <= 1'b1;
            counter <= 13'd0;
          end
      end
endmodule

