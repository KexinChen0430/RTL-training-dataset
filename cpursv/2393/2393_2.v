
module Keyboard_dev(input  clk,
                    input  reset,
                    input  kbd_clk,
                    input  kbd_data,
                    output reg ready_pulse,
                    output reg [7:0] Keyboard_Data);

  reg  [3:0] counter;
  reg  [3:0] last;

  
  initial  
  begin
    Keyboard_Data <= 8'b0;
    ready_pulse <= 1'b0;
    counter <= 4'b0;
    last <= 4'b0;
  end
  
  always @(negedge kbd_clk)
      begin
        case (counter)

          0: begin
                counter <= counter+1;
              end

          1: begin
                counter <= counter+1;
                Keyboard_Data[0] <= kbd_data;
              end

          2: begin
                counter <= counter+1;
                Keyboard_Data[1] <= kbd_data;
              end

          3: begin
                counter <= counter+1;
                Keyboard_Data[2] <= kbd_data;
              end

          4: begin
                counter <= counter+1;
                Keyboard_Data[3] <= kbd_data;
              end

          5: begin
                counter <= counter+1;
                Keyboard_Data[4] <= kbd_data;
              end

          6: begin
                counter <= counter+1;
                Keyboard_Data[5] <= kbd_data;
              end

          7: begin
                counter <= counter+1;
                Keyboard_Data[6] <= kbd_data;
              end

          8: begin
                counter <= counter+1;
                Keyboard_Data[7] <= kbd_data;
              end

          9: begin
                counter <= counter+1;
              end

          10: begin
                counter <= 4'b0;
              end

        endcase

      end
  
  always @(posedge clk)
      begin
        ready_pulse <= (counter == 4'd10) && (last != 4'd10);
        last <= counter;
      end
endmodule

