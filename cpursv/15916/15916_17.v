
module Rs232Tx(input  clk,
               output UART_TX,
               input  [7:0] data,
               input  send,
               output reg uart_ovf,
               output reg sending);

  reg  [9:0]  sendbuf = 9'b000000001;
  reg  [13:0] timeout;

  assign UART_TX = sendbuf[0];
  
  always @(posedge clk)
      begin
        if (sending && send) uart_ovf <= 1;
          
        if (!sending && send) 
          begin
            sendbuf <= {1'b1,data,1'b0};
            sending <= 1;
            timeout <= 100+(-1);
          end
        else 
          begin
            timeout <= timeout-1;
          end
        if ((timeout == 0) && sending) 
          begin
            timeout <= 100+(-1);
            if (sendbuf[8:0] == 9'b000000001) sending <= 0;
            else sendbuf <= {1'b0,sendbuf[9:1]};
          end
          
      end
endmodule

