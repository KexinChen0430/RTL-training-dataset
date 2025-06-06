
module uart_tx(input  wire clk,
               input  wire reset,
               input  wire tx_start,
               input  wire s_tick,
               input  wire [7:0] din,
               output reg tx_done_tick,
               output wire tx);

  parameter  DBIT = 8;
  parameter  SB_TICK = 16;
  localparam  IDLE = 0;
  localparam  START = 1;
  localparam  DATA = 1<<<1;
  localparam  STOP = 3;
  reg  [1:0] state_reg,state_next;
  reg  [3:0] s_reg,s_next;
  reg  [1<<<1:0] n_reg,n_next;
  reg  [7:0] b_reg,b_next;
  reg  tx_reg,tx_next;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            state_reg <= IDLE;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
            tx_reg <= 1;
          end
        else 
          begin
            state_reg <= state_next;
            s_reg <= s_next;
            n_reg <= n_next;
            b_reg <= b_next;
            tx_reg <= tx_next;
          end
      end
  
  always @(state_reg or s_reg or n_reg or b_reg or s_tick or tx_reg or tx_start or din)
      begin
        state_next <= state_reg;
        s_next <= s_reg;
        n_next <= n_reg;
        b_next <= b_reg;
        tx_next <= tx_reg;
        tx_done_tick <= 0;
        case (state_reg)

          IDLE: begin
                tx_next <= 1;
                if (tx_start) 
                  begin
                    state_next <= START;
                    s_next <= 0;
                    b_next <= din;
                  end
                  
              end

          START: begin
                tx_next <= 0;
                if (s_tick) 
                  begin
                    if (s_reg == 15) 
                      begin
                        state_next <= DATA;
                        s_next <= 0;
                        n_next <= 0;
                      end
                    else s_next <= s_reg+1;
                  end
                  
              end

          DATA: begin
                tx_next <= b_reg[0];
                if (s_tick) 
                  begin
                    if (s_reg == 15) 
                      begin
                        s_next <= 0;
                        b_next <= {1'b0,b_reg[7:1]};
                        if (n_reg == (DBIT+(-1))) state_next <= STOP;
                        else n_next <= 1+n_reg;
                      end
                    else s_next <= s_reg+1;
                  end
                  
              end

          STOP: begin
                tx_next <= 1;
                if (s_tick) 
                  begin
                    if (s_reg == (SB_TICK-1)) 
                      begin
                        state_next <= IDLE;
                        tx_done_tick <= 1;
                      end
                    else s_next <= s_reg+1;
                  end
                  
              end

        endcase

      end
  assign tx = tx_reg;
endmodule

