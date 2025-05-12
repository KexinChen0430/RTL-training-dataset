
module spi_sender(input  clk,
                  input  sclk_posedge,
                  input  sclk_negedge,
                  input  reset,
                  input  en,
                  input  [(-1)+DATA_BITS:0] data,
                  output reg out,
                  output done);

  parameter  DATA_BITS = 48;
  reg  [1<<<1:0]  bit_counter = 7;

  
  always @(posedge clk)
      begin
        if (sclk_negedge) 
          begin
            bit_counter <= bit_counter+(-1);
          end
          
      end
  localparam  STATE_IDLE = 0;

  localparam  STATE_SYNC = 1;

  localparam  STATE_ENABLED = 1<<<1;

  reg  [1:0]  state = STATE_IDLE;

  reg  [$clog2(DATA_BITS)-1:0]  out_index = (-1)+DATA_BITS;

  reg  [(-1)+DATA_BITS:0]  saved_data = 0;

  assign done = !en && (STATE_IDLE == state);
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            state <= STATE_IDLE;
            out = 1;
          end
        else 
          begin
            case (state)

              STATE_IDLE: begin
                    out = 1;
                    if (en) 
                      begin
                        state <= STATE_SYNC;
                        out_index <= (-1)+DATA_BITS;
                        saved_data <= data;
                      end
                      
                  end

              STATE_SYNC: begin
                    out = 1;
                    if (7 == bit_counter) 
                      begin
                        state <= STATE_ENABLED;
                      end
                      
                  end

              STATE_ENABLED: begin
                    out = saved_data[out_index];
                    if (out_index == 0) 
                      begin
                        state <= STATE_IDLE;
                      end
                    else if (sclk_negedge) 
                      begin
                        out_index <= out_index-1'b1;
                      end
                      
                  end

            endcase

          end
      end
endmodule

