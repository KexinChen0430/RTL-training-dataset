
module Countdowner(clk_i,second_in,signal_i,second_o);

  input  clk_i;
  input  [31:0] second_in;
  input  [1<<1:0] signal_i;
  output [31:0] second_o;
  reg  [31:0] counter;
  reg  [1:0] state;
  reg  [31:0] second;

  assign second_o = second;
  
  initial  
  begin
    state = 2'b00;
    counter = 0;
    second = 0;
  end
  
  always @(negedge clk_i)
      begin
        case (state)

          2'b00: begin
                case (signal_i)

                  3'b101: begin
                        second <= second_in;
                      end

                  3'b111: begin
                        state <= 2'b01;
                      end

                endcase

              end

          2'b01: begin
                if (counter == 32'd25000) 
                  begin
                    counter <= 1;
                    if (second != 32'b0) 
                      begin
                        second <= second+(-1);
                      end
                      
                  end
                else 
                  begin
                    counter <= 1+counter;
                  end
                case (signal_i)

                  3'b101: begin
                        state <= 2'b00;
                        counter <= 0;
                        second <= second_in;
                      end

                  3'b111: begin
                        state <= 2'b10;
                      end

                endcase

              end

          2'b10: begin
                case (signal_i)

                  3'b101: begin
                        state <= 2'b00;
                        counter <= 0;
                        second <= second_in;
                      end

                  3'b111: begin
                        state <= 2'b01;
                      end

                endcase

              end

        endcase

      end
endmodule

