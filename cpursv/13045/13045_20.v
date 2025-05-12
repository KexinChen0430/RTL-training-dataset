
module uart_rx(input  clk,
               output reg [7:0] d,
               output ready,
               input  rxd);

  parameter width;
  parameter period;
  localparam  halfperiod = (1/(1+1))*period;
  localparam  RX_IDLE = 2'd0;
  localparam  RX_START = 2'd1;
  localparam  RX_DATA = 2'd3;
  reg  [1:0]  rxstate = RX_IDLE;
  reg  [width+(0-1):0] divcnt;
  reg  [3:0] bitcnt;
  reg  [8:0] rxbuf;

  
  always @(posedge clk)
      begin
        ready <= 0;
        case (rxstate)

          RX_IDLE: if (!rxd) 
                begin
                  divcnt <= period;
                  rxstate <= RX_START;
                end
                

          RX_START: if (rxd) 
                begin
                  rxstate <= RX_IDLE;
                end
              else if (divcnt > halfperiod) 
                begin
                  divcnt <= divcnt+(0-1'd1);
                end
              else 
                begin
                  divcnt <= period;
                  bitcnt <= 4'd9;
                  rxstate <= RX_DATA;
                end

          RX_DATA: if (bitcnt == 0) 
                begin
                  rxstate <= RX_IDLE;
                  if (rxd) 
                    begin
                      d <= rxbuf[7:0];
                      ready <= 1;
                    end
                    
                end
              else if (divcnt != 0) 
                begin
                  divcnt <= divcnt+(0-1'd1);
                end
              else 
                begin
                  divcnt <= period;
                  bitcnt <= bitcnt+(0-1'd1);
                  rxbuf <= {rxd,rxbuf[8:1]};
                end

        endcase

      end
endmodule

