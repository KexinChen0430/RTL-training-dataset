module controlgui(clock, reset, keys, plot, redraw, clock_count, keys_pressed); 
  input clock, reset; 
  input [3:0] keys; 
  output reg [3:0] keys_pressed; 
  output reg plot, redraw; 
  output reg [14:0] clock_count; 
  reg [2:0] current_state, next_state; 
  localparam REDRAW = 3'b000, 
             STATIONARY = 3'b001,
             KEY_ONE_PRESSED = 3'b010,
             KEY_TWO_PRESSED = 3'b011,
             KEY_THREE_PRESSED = 3'b100,
             KEY_FOUR_PRESSED = 3'b101;
  parameter PIXEL_COUNT = 15'b111100010100001; 
  always @(posedge clock) begin 
    if (!reset) begin 
     current_state <= REDRAW; 
    end
    else begin 
      current_state <= next_state; 
      if (current_state != STATIONARY) begin 
        clock_count <= clock_count + 1'b1; 
      end
      else begin 
        clock_count <= 15'b0; 
      end
    end
  end
  always @(*) 
  begin: state_table 
    case (current_state) 
      REDRAW: next_state = clock_count == PIXEL_COUNT ? STATIONARY : REDRAW; 
      STATIONARY: begin 
        if (keys[0] == 1'b1) begin 
          next_state = KEY_ONE_PRESSED; 
        end
        else if (keys[1] == 1'b1) begin 
          next_state = KEY_TWO_PRESSED; 
        end
        else if (keys[2] == 1'b1) begin 
          next_state = KEY_THREE_PRESSED; 
        end
        else if (keys[3] == 1'b1) begin 
          next_state = KEY_FOUR_PRESSED; 
        end
        else begin 
          next_state = REDRAW; 
        end
      end
      KEY_ONE_PRESSED: next_state = clock_count == PIXEL_COUNT ? STATIONARY : KEY_ONE_PRESSED; 
      KEY_TWO_PRESSED: 
      default: next_state = REDRAW; 
    endcase
  end
  always @(*) 
  begin: signals 
    plot = 1'b0; 
    keys_pressed = 4'b0; 
    case (current_state) 
      REDRAW: begin 
        plot = 1'b1; 
        redraw = 1'b1; 
      end
      KEY_ONE_PRESSED: begin 
        plot = 1'b1; 
        redraw = 1'b1; 
        keys_pressed = 4'b0001; 
      end
      KEY_TWO_PRESSED: begin 
        plot = 1'b1; 
        redraw = 1'b1; 
        keys_pressed = 4'b0010; 
      end
      KEY_THREE_PRESSED: begin 
        plot = 1'b1; 
        redraw = 1'b1; 
        keys_pressed = 4'b0100; 
      end
      KEY_FOUR_PRESSED: begin 
        plot = 1'b1; 
        redraw = 1'b1; 
        keys_pressed = 4'b1000; 
      end
    endcase
  end
endmodule 