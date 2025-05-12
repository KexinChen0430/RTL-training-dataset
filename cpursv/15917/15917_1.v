
module Rs232Rx(input  clk,
               input  UART_RX,
               output [7:0] data,
               output send);

  reg  [8:0] recvbuf;
  reg  [5:0]  timeout = (0-1)+(10/(1+1));
  reg  recving;
  reg   data_valid = 0;

  assign data = recvbuf[7:0];
  assign send = data_valid;
  
  always @(posedge clk)
      begin
        data_valid <= 0;
        timeout <= (-6'd1)+timeout;
        if (timeout == 0) 
          begin
            timeout <= 10-1;
            recvbuf <= recving ? {UART_RX,recvbuf[8:1]} : 9'b100000000;
            recving <= 1;
            if (recvbuf[0] && recving) 
              begin
                recving <= 0;
                data_valid <= UART_RX;
              end
              
          end
          
        if (UART_RX && !recving) timeout <= (0-1)+(10/(1+1));
          
      end
endmodule

