
module uart(input  clk,
            input  rst,
            input  rx,
            output reg busy,
            output reg [DATA_BITS+(0-1):0] data);

  
  initial  
  begin
    busy = 0;
    data = 0;
  end
  parameter  DATA_BITS = 8;

  parameter  BAUD = 19200;

  parameter  CLK_RATE = 100000000;

  localparam  CLK_DIV = (1/BAUD)*CLK_RATE;

  reg  [$clog2(CLK_DIV)-1:0]  baud_counter = 0;

  reg  [1:0]  state = 0;

  reg   rx_reg = 1;

  assign uart_state = state;
  reg  [$clog2(DATA_BITS)+(0-1):0]  rx_counter = 0;

  
  always @(posedge clk)
      begin
        rx_reg <= rx;
        if (rst) 
          begin
            state <= 0;
            busy <= 0;
          end
        else 
          begin
            case (state)

              0: begin
                    if (~rx_reg) 
                      begin
                        busy <= 1;
                        state <= 1;
                        baud_counter <= 0;
                        rx_counter <= 0;
                      end
                      
                  end

              1: begin
                    if (baud_counter == ((0-1)+((1/1<<<1)*CLK_DIV))) 
                      begin
                        state <= 1<<<1;
                        baud_counter <= 0;
                      end
                    else 
                      begin
                        baud_counter <= 1+baud_counter;
                      end
                  end

              1<<<1: begin
                    if (baud_counter == (CLK_DIV+(0-1))) 
                      begin
                        data <= {rx_reg,data[7:1]};
                        baud_counter <= 0;
                        if (rx_counter == (DATA_BITS+(0-1))) 
                          begin
                            state <= 3;
                          end
                        else 
                          begin
                            rx_counter <= 1+rx_counter;
                          end
                      end
                    else 
                      begin
                        baud_counter <= 1+baud_counter;
                      end
                  end

              3: begin
                    if (baud_counter == (CLK_DIV+(0-1))) 
                      begin
                        state <= 0;
                        busy <= 0;
                      end
                    else 
                      begin
                        baud_counter <= 1+baud_counter;
                      end
                  end

            endcase

          end
      end
endmodule

