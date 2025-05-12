module datapathgui(clock,
                   reset,
                   redraw,
                   colour,
                   x,
                   y,
                   clock_count);
  input clock, reset, redraw;
  input [14:0] clock_count;
  input [3:0] keys_pressed;
  output reg [2:0] colour;
  output reg [7:0] x;
  output reg [6:0] y;
  reg [7:0] temp_x;
  reg [6:0] temp_y;
  localparam WHITE = 3'b111,
             BLACK = 3'b000,
             BLUE = 3'b001,
             RED = 3'b100;
  parameter FIRST_DIVIDER = 8'b00100111;
  parameter SECOND_DIVIDER = 8'b01001111;
  parameter THIRD_DIVIDER = 8'b01110111;
  parameter MAX_X = 8'b10100000;
  parameter MAX_Y = 7'b1111000;
  always @(posedge clock) begin
    if (!reset) begin
      x <= 8'b0;
      y <= 8'b0;
      colour <= 3'b0;
      temp_x <= 8'b0;
      temp_y <= 7'b0;
    end
    else if (redraw) begin
      if (clock_count[7:0] == FIRST_DIVIDER || clock_count[7:0] == SECOND_DIVIDER || clock_count[7:0] == THIRD_DIVIDER) begin
        colour <= BLACK;
      end
      else begin
        if (keys_pressed == 4'b0001 & clock_count[7:0] < FIRST_DIVIDER) begin 
          colour <= BLUE;
        end
        else if (keys_pressed == 4'b0010 & clock_count[7:0] > FIRST_DIVIDER & clock_count[7:0] < SECOND_DIVIDER) begin 
          colour <= BLUE;
        end
        else if (keys_pressed == 4'b0100 & clock_count[7:0] > SECOND_DIVIDER & clock_count[7:0] < THIRD_DIVIDER) begin 
          colour <= BLUE;
        end
        else if (keys_pressed == 4'b1000 & clock_count[7:0] > THIRD_DIVIDER ) begin 
          colour <= BLUE;
        end
        else begin
          colour <= WHITE;
        end
      end
      if (!(clock_count[7:0] > MAX_X)) begin
 	 x <= temp_x + clock_count[7:0];
      end
      if (!(clock_count[14:8] > MAX_Y)) begin
 	 y <= temp_y + clock_count[14:8];
      end
    end
  end
endmodule