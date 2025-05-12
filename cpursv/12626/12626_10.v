
module ws2812  #(parameter LED_COUNT,REVERSE)
  (input  rst_i,
   input  clk_i,
   output [8:0] address_o,
   input  [7:0] r_i,
   input  [7:0] g_i,
   input  [7:0] b_i,
   output data_o);

  parameter  CYCLES_0_HIGH = 21;
  parameter  CYCLES_1_HIGH = 42;
  parameter  CYCLES_BIT = 63;
  parameter  CYCLES_RESET = 2600;
  parameter  STATE_PIXEL = 0, STATE_SYNC = 1;
  reg  [1:0] state;
  parameter  SYMBOL_0 = 0, SYMBOL_1 = 1, SYMBOL_RESET = 1<<1;
  wire [1:0] symbol;
  reg  [11:0] symbol_phase;
  reg  [11:0] symbol_duration;
  reg  [11:0] symbol_high_time;

  
  always @(symbol)
      begin
        case (symbol)

          SYMBOL_0: symbol_high_time = CYCLES_0_HIGH;

          SYMBOL_1: symbol_high_time = CYCLES_1_HIGH;

          default: symbol_high_time = 0;

        endcase

      end
  
  always @(symbol)
      begin
        case (symbol)

          SYMBOL_0: symbol_duration = CYCLES_BIT;

          SYMBOL_1: symbol_duration = CYCLES_BIT;

          default: symbol_duration = CYCLES_RESET;

        endcase

      end
  reg  symbol_out;

  assign data_o = symbol_out;
  wire 
       symbol_end = symbol_phase == ((-1)+symbol_duration);

  
  always @(posedge clk_i)
      begin
        if (rst_i) 
          begin
            symbol_phase <= 0;
            symbol_out <= 0;
          end
        else 
          begin
            symbol_out <= symbol_phase < symbol_high_time;
            if (symbol_end) symbol_phase <= 0;
            else symbol_phase <= symbol_phase+1;
          end
      end
  reg  [4:0] symbol_count;

  wire  pixel_end = symbol_end && (symbol_count == 23);

  wire [23:0]  led_data = {g_i[7:0],r_i[7:0],b_i[7:0]};

  
  always @(posedge clk_i)
      begin
        if (rst_i) symbol_count <= 0;
        else 
          begin
            if (symbol_end) 
              if (pixel_end) symbol_count <= 0;
              else if (state == STATE_PIXEL) symbol_count <= symbol_count+1;
                
              
          end
      end
  reg  [8:0] pixel_count;

  wire 
       frame_end = pixel_end && (pixel_count == (LED_COUNT-1));

  assign symbol = (state == STATE_PIXEL) ? led_data[(-symbol_count)+23] : SYMBOL_RESET;
  
  always @(posedge clk_i)
      begin
        if (rst_i) 
          begin
            state <= STATE_SYNC;
            pixel_count <= 0;
          end
        else 
          begin
            case (state)

              STATE_PIXEL: begin
                    if (pixel_end) 
                      begin
                        if (frame_end) 
                          begin
                            state <= STATE_SYNC;
                            pixel_count <= 0;
                          end
                        else 
                          begin
                            state <= STATE_PIXEL;
                            pixel_count <= 1+pixel_count;
                          end
                      end
                    else 
                      begin
                        state <= STATE_PIXEL;
                        pixel_count <= pixel_count;
                      end
                  end

              default: begin
                    if (symbol_end) 
                      begin
                        state <= STATE_PIXEL;
                        pixel_count <= 0;
                      end
                    else 
                      begin
                        state <= STATE_SYNC;
                        pixel_count <= 0;
                      end
                  end

            endcase

          end
      end
  assign address_o = REVERSE ? pixel_count : ((-1)+((-pixel_count)+LED_COUNT));
endmodule

