
module Claps(input  clk_48,
             input  rst,
             input  [9:0] mic_sample,
             output reg home_state,
             output [3:0] debug);

  reg  [2:0] state,state_d;
  reg  [2:0] state_after,state_after_d;
  reg  [31:0] delay,delay_d;
  reg  home_state_d;
  localparam  THRESHOLD = 10'd770;
  localparam  DELAY_SIM = 32'h4;
  localparam  DELAY_QUARTERSEC = 32'hB71B00;
  localparam  DELAY_2SEC = 32'h5B8D800;
  localparam 
       WAIT_CLAP1   = 3'd0,
       DELAY_CLAP2  = 3'd1,
       WAIT_CLAP2   = 3'd2,
       TOGGLE_STATE = 3'd3,
       DELAY_RESET  = 3'd4;

  assign debug = state;
  
  always @(posedge clk_48 or posedge rst)
      begin
        if (rst) 
          begin
            state <= WAIT_CLAP1;
            state_after <= WAIT_CLAP1;
            delay <= 32'h0;
            home_state <= 1'b0;
          end
        else 
          begin
            state <= state_d;
            state_after <= state_after_d;
            delay <= delay_d;
            home_state <= home_state_d;
          end
      end
  
  always @(*)
      begin
        state_d = state;
        state_after_d = state_after;
        delay_d = delay;
        home_state_d = home_state;
        case (state)

          WAIT_CLAP1: begin
                if (mic_sample > THRESHOLD) 
                  begin
                    state_d = DELAY_CLAP2;
                    delay_d = DELAY_QUARTERSEC;
                  end
                else state_d = WAIT_CLAP1;
              end

          DELAY_CLAP2: begin
                if (delay == 32'b0) 
                  begin
                    state_d = WAIT_CLAP2;
                    delay_d = DELAY_2SEC;
                  end
                else delay_d = (0-1'b1)+delay;
              end

          WAIT_CLAP2: begin
                if (delay == 32'b0) 
                  begin
                    state_d = WAIT_CLAP1;
                  end
                else 
                  begin
                    delay_d = (0-1'b1)+delay;
                    if (mic_sample > THRESHOLD) state_d = TOGGLE_STATE;
                    else state_d = WAIT_CLAP2;
                  end
              end

          TOGGLE_STATE: begin
                state_d = DELAY_RESET;
                delay_d = DELAY_2SEC;
                if (home_state == 1'b1) home_state_d = 1'b0;
                else home_state_d = 1'b1;
              end

          DELAY_RESET: begin
                if (delay == 32'b0) state_d = WAIT_CLAP1;
                else delay_d = (0-1'b1)+delay;
              end

        endcase

      end
endmodule

