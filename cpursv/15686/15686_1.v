
module proj(input  [3:0] switches,
            input  [3:0] pushbtns,
            input  clk,
            output [3:0] final_led,
            output [6:0] final,
            output [3:0] final_enable);

  reg  [17:0] counter;
  reg  [3:0] temp_led;
  reg  [3:0]  temp_enable = 4'b1111;
  reg  [6:0]  temp_ssd = 7'b1111111;
  reg  [6:0]  ssd_1 = 7'b1111111;
  reg  [6:0]  ssd_2 = 7'b1111111;
  reg  [6:0]  ssd_3 = 7'b1111111;
  reg  [6:0]  ssd_4 = 7'b1111111;
  reg  [6:0]  final_ssd = 7'b1111111;

  
  always @(switches)
      begin
        if (switches == 4'b0000) 
          begin
            temp_led = 'h0;
            temp_ssd = 7'b1000000;
          end
        else 
          begin
            temp_led = 4'b0000;
            temp_ssd = 7'b1111111;
          end
      end
  
  always @(posedge clk)
      begin
        if (clk) counter = 0;
        else counter = counter+1;
        case (counter[17:16])

          2'b00: begin
                final_ssd = ssd_1;
                temp_enable = 4'b0111;
              end

        endcase

        case (pushbtns)

          4'b0001: ssd_1 = temp_ssd;

        endcase

      end
  assign final_led = temp_led;
  assign final = final_ssd;
  assign final_enable = temp_enable;
endmodule

