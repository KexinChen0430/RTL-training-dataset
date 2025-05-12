
module sounds_module(input  lrck,
                     input  reset,
                     input  [2:0] sound_code,
                     output reg [15:0] left_data,
                     output reg [15:0] right_data);

  reg  [2:0] position;
  parameter [15:0] sample_sound_left[2:0];
  parameter [15:0] sample_sound_right[2:0];

  
  initial  
  begin
    position <= 1;
    sample_sound_left[0] <= 16'd1;
    sample_sound_right[0] <= 16'd2;
    sample_sound_left[1] <= 16'd3;
    sample_sound_right[1] <= 16'd4;
    sample_sound_left[2] <= 16'd5;
    sample_sound_right[2] <= 16'd6;
  end
  
  always @(negedge lrck)
      begin
        case (sound_code)

          3'b000: begin
                left_data <= sample_sound_left[position];
                right_data <= sample_sound_right[position];
              end

          default: begin
                left_data <= sample_sound_left[position];
                right_data <= sample_sound_right[position];
              end

        endcase

        position <= position+1;
      end
endmodule

