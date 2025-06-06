
module messbauer_diff_discriminator_signals  #(parameter 
       GCLK_PERIOD                  = 20,
       LOWER_THRESHOLD_DURATION     = 3,
       UPPER_THRESHOLD_DURATION     = 1,
       DISCRIMINATOR_IMPULSES_PAUSE = 10,
       IMPULSES_PER_CHANNEL         = 16,
       IMPULSES_FOR_SELECTION       = 4)
  (input  wire aclk,
   input  wire areset_n,
   input  wire channel,
   output reg lower_threshold,
   output reg upper_threshold);

  localparam  INITIAL_STATE = 0;
  localparam  LOWER_THRESHOLD_HIGH_PHASE = 1;
  localparam  UPPER_THRESHOLD_HIGH_PHASE = 2;
  localparam  UPPER_THRESHOLD_LOW_PHASE = 3;
  localparam  LOWER_THRESHOLD_LOW_PHASE = 4;
  localparam  FINAL_STATE = 5;
  localparam  PAUSE_DURATION = 4;
  reg  enable;
  reg  first_enable;
  reg  [15:0] clk_counter;
  reg  [15:0] impulse_counter;
  reg  [15:0] total_impulse_counter;
  reg  [2:0] state;
  reg  impulse_rejected;
  reg  period_done;

  
  always @(posedge aclk)
      begin
        if (~areset_n) 
          begin
            clk_counter <= 0;
            impulse_counter <= 0;
            total_impulse_counter <= 0;
            state <= INITIAL_STATE;
            lower_threshold <= 0;
            upper_threshold <= 0;
            first_enable <= 1;
            impulse_rejected <= 1;
          end
        else 
          begin
            if (first_enable || enable) 
              begin
                clk_counter <= clk_counter+1'b1;
                case (state)

                  INITIAL_STATE: begin
                        clk_counter <= 0;
                        state <= LOWER_THRESHOLD_HIGH_PHASE;
                        impulse_rejected <= 0;
                        period_done <= 0;
                      end

                  LOWER_THRESHOLD_HIGH_PHASE: begin
                        lower_threshold <= 1;
                        if (clk_counter == 1) 
                          begin
                            if (impulse_counter <= IMPULSES_FOR_SELECTION) state <= LOWER_THRESHOLD_LOW_PHASE;
                            else state <= UPPER_THRESHOLD_HIGH_PHASE;
                          end
                          
                      end

                  UPPER_THRESHOLD_HIGH_PHASE: begin
                        impulse_rejected <= 1;
                        upper_threshold <= 1;
                        if (clk_counter == (1+UPPER_THRESHOLD_DURATION)) state <= UPPER_THRESHOLD_LOW_PHASE;
                          
                      end

                  UPPER_THRESHOLD_LOW_PHASE: begin
                        state <= LOWER_THRESHOLD_LOW_PHASE;
                        upper_threshold <= 0;
                      end

                  LOWER_THRESHOLD_LOW_PHASE: begin
                        lower_threshold <= 0;
                        if (clk_counter >= LOWER_THRESHOLD_DURATION) 
                          begin
                            if (impulse_rejected == 0) impulse_counter <= 1'b1+impulse_counter;
                              
                            total_impulse_counter <= total_impulse_counter+1'b1;
                            if (total_impulse_counter < IMPULSES_PER_CHANNEL) state <= INITIAL_STATE;
                            else state <= FINAL_STATE;
                          end
                          
                      end

                  FINAL_STATE: begin
                        impulse_counter <= 0;
                        total_impulse_counter <= 0;
                        period_done <= 1;
                        first_enable <= 0;
                      end

                  default: begin

                      end

                endcase

              end
            else state <= INITIAL_STATE;
          end
      end
  
  always @(posedge channel or negedge areset_n)
      begin
        if (~areset_n) enable = 0;
        else 
          begin
            if (period_done) enable = ~enable;
              
          end
      end
endmodule

