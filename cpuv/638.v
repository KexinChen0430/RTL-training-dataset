module controlrecorder(
  input clock,          
  input reset,          
  input go,             
  input [25:0] countdown, 
  output reg [1:0] mode,  
  output reg [4:0] cell_number, 
  output reg [25:0] cyclecounter 
);
  reg [3:0] prev_keys; 
  reg [2:0] current_state, next_state; 
  reg [25:0] countdown_register; 
  localparam STATIONARY = 3'b000,
             START_RECORD = 3'b001,
             RECORDING = 3'b010,
             WAITING_FOR_PLAYBACK = 3'b011,
             START_PLAYBACK = 3'b100,
             PLAYBACK = 3'b101;
  always @(posedge clock) begin
    if (!reset) begin
      current_state <= STATIONARY;
    end
    else begin
      current_state <= next_state;
      if (current_state == START_RECORD || current_state == START_PLAYBACK) begin
        cyclecounter <= 26'b0;
        cell_number <= 5'b0;
      end
      else if (current_state == RECORDING) begin
        if (~(prev_keys == keys)) begin
          cyclecounter <= 26'b0;
          cell_number <= cell_number + 1'b1;
        end
        else if (cyclecounter == 26'b10111110101111000001111111) begin
          cyclecounter <= 26'b0;
          cell_number <= cell_number + 1'b1;
        end
        else begin
          cyclecounter <= cyclecounter + 1'b1;
        end
      end
      else if (current_state == PLAYBACK) begin
        if (countdown_register != 26'b0) begin
          countdown_register <= countdown_register - 1'b1;
        end
        else begin
          cell_number <= cell_number + 1'b1;
        end
      end
      prev_keys <= keys;
    end
  end
  always @(*) begin: state_table
    case(current_state)
      STATIONARY: next_state = go ? START_RECORD : STATIONARY;
      START_RECORD: next_state = go ? RECORDING : START_RECORD;
      RECORDING: next_state = (cell_number == 5'b11110) ? WAITING_FOR_PLAYBACK : RECORDING;
      WAITING_FOR_PLAYBACK: next_state = go ? START_PLAYBACK : WAITING_FOR_PLAYBACK;
      START_PLAYBACK: next_state = go ? PLAYBACK : START_PLAYBACK;
      PLAYBACK: next_state = (cell_number == 5'b11110) ? STATIONARY : PLAYBACK;
      default: next_state = STATIONARY;
    endcase
  end
  always @(countdown) begin
    countdown_register <= countdown;
  end
  always @(*) begin: signals
    mode = 2'b0; 
    case (current_state)
      RECORDING: begin
        mode = 2'b01; 
      end
      PLAYBACK: begin
        mode = 2'b10; 
      end
    endcase
  end
endmodule