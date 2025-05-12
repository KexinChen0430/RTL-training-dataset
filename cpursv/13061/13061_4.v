
module uart_tx(input  clk,
               input  [7:0] d,
               input  send,
               output ready,
               output txd);

  parameter width;
  parameter period;
  localparam  TX_IDLE = 2'd0;
  localparam  TX_SEND = 2'd1;
  localparam  TX_WAIT = 2'd2;
  reg  [1:0]  txstate = TX_IDLE;
  reg  [width+(0-1):0] divcnt;
  reg  [3:0] bitcnt;
  reg  [0:10]  txbuf = {11'b11111111111};

  
  always @(posedge clk)
      begin
        ready <= 0;
        case (txstate)

          TX_IDLE: if (send) 
                begin
                  bitcnt <= 4'd10;
                  txbuf <= {1'b1,1'b1,d,1'b0};
                  divcnt <= period;
                  txstate <= TX_WAIT;
                end
                

          TX_SEND: begin
                txbuf <= {1'b1,txbuf[0:9]};
                divcnt <= period;
                txstate <= TX_WAIT;
              end

          TX_WAIT: if (divcnt != 0) 
                begin
                  divcnt <= divcnt+(0-1'd1);
                end
              else 
                begin
                  if (bitcnt == 1) 
                    begin
                      ready <= 1;
                      txstate <= TX_IDLE;
                    end
                  else 
                    begin
                      bitcnt <= (0-1'd1)+bitcnt;
                      txstate <= TX_SEND;
                    end
                end

        endcase

      end
  assign txd = txbuf[10];
endmodule

