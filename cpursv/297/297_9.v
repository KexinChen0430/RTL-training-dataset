
module button_debounce(input  clk,
                       input  reset_n,
                       input  button,
                       output reg debounce);

  parameter  CLK_FREQUENCY = 66000000, DEBOUNCE_HZ = 1<<1;
  localparam 
       COUNT_VALUE = CLK_FREQUENCY*(1/DEBOUNCE_HZ),
       WAIT        = 0,
       FIRE        = 1,
       COUNT       = 1<<1;
  reg  [1:0] state,next_state;
  reg  [25:0] count;

  
  always @(posedge clk or negedge reset_n)
      state <= !reset_n ? WAIT : next_state;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (!reset_n) 
          begin
            debounce <= 0;
            count <= 0;
          end
        else 
          begin
            debounce <= 0;
            count <= 0;
            case (state)

              WAIT: begin

                  end

              FIRE: begin
                    debounce <= 1;
                  end

              COUNT: begin
                    count <= count+1;
                  end

            endcase

          end
      end
  
  always @* 
      begin
        case (state)

          WAIT: next_state = button ? FIRE : state;

          FIRE: next_state = COUNT;

          COUNT: next_state = (count > (COUNT_VALUE-1)) ? WAIT : state;

          default: next_state = WAIT;

        endcase

      end
endmodule

