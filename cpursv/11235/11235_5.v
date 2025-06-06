
module uartcon_rx(input  rst_n,
                  input  clk,
                  input  rxd,
                  output valid,
                  output [7:0] data);

  reg  [2:0] reg_rxd;
  reg  [1:0] sample_count;
  reg  [2:0] bit_count;
  reg  [7:0] rx_data;
  reg  [3:0] state;
  localparam  S_IDLE = 4'd0;
  localparam  S_START = 4'd1;
  localparam  S_DATA = 4'd2;
  localparam  S_STOP = 4'd3;
  localparam  S_LAST = 4'd4;
  wire detect_startbit,sample_point;

  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            reg_rxd[2:0] <= 3'd0;
          end
        else 
          begin
            reg_rxd[2:0] <= {reg_rxd[1:0],rxd};
          end
      end
  assign detect_startbit = (reg_rxd[2] == 1'b1) && (reg_rxd[1] == 1'b0) && 
                           (state == S_IDLE);
  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            sample_count[1:0] <= 2'd0;
          end
        else 
          begin
            if (detect_startbit == 1'b1) 
              begin
                sample_count[1:0] <= 2'd0;
              end
            else 
              begin
                sample_count[1:0] <= sample_count[1:0]+2'd1;
              end
          end
      end
  assign sample_point = (sample_count[1:0] == 2'd0) ? 1'b1 : 1'b0;
  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            state <= S_IDLE;
            bit_count[2:0] <= 3'd0;
            rx_data[7:0] <= 8'd0;
          end
        else 
          begin
            case (state)

              S_IDLE: begin
                    if (detect_startbit == 1'b1) 
                      begin
                        state <= S_START;
                        bit_count[2:0] <= 3'd0;
                      end
                      
                  end

              S_START: begin
                    if (sample_point == 1'b1) 
                      begin
                        if (reg_rxd[1] == 1'b0) 
                          begin
                            state <= S_DATA;
                          end
                        else 
                          begin
                            state <= S_IDLE;
                          end
                      end
                      
                  end

              S_DATA: begin
                    if (sample_point == 1'b1) 
                      begin
                        rx_data[7:0] <= {reg_rxd[1],rx_data[7:1]};
                        if (bit_count[2:0] == 3'd7) 
                          begin
                            state <= S_STOP;
                          end
                        else 
                          begin
                            bit_count[2:0] <= 3'd1+bit_count[2:0];
                          end
                      end
                      
                  end

              S_STOP: begin
                    if (sample_point == 1'b1) 
                      begin
                        if (reg_rxd[1] == 1'b1) 
                          begin
                            state <= S_LAST;
                          end
                        else 
                          begin
                            state <= S_IDLE;
                          end
                      end
                      
                  end

              S_LAST: begin
                    state <= S_IDLE;
                  end

            endcase

          end
      end
  assign valid = (state == S_LAST) ? 1'b1 : 1'b0;
  assign data[7:0] = rx_data[7:0];
endmodule

