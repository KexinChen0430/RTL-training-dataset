
module FSM_Main(input  clock,
                input  reset,
                input  start,
                input  v_sync,
                input  perdio,
                output actualizar_bola,
                output actualizar_barra,
                output revisar_bordes_bola,
                output revisar_bordes_barra,
                output reg revisar_estado,
                output reg reset_bola,
                output reg reset_barra);

  reg  start_barra,start_ball;
  wire busy_barra,busy_ball;

  FSM_Barra fsm_barra(.clock(clock),.reset(reset),
                      .start_barra(start_barra),.busy_barra(busy_barra),
                      .actualizar_barra(actualizar_barra),.revisar_bordes_barra(revisar_bordes_barra));
  FSM_Bola fsm_bola(.clock(clock),.reset(reset),
                    .start_ball(start_ball),.busy_ball(busy_ball),
                    .actualizar_bola(actualizar_bola),.revisar_bordes_bola(revisar_bordes_bola));
  parameter  STATE_0 = 0;

  parameter  STATE_1 = 1;

  parameter  STATE_2 = 2;

  parameter  STATE_3 = 3;

  parameter  STATE_4 = 4;

  parameter  STATE_5 = 5;

  parameter  STATE_6 = 6;

  parameter  STATE_7 = 7;

  reg  [2:0] state;

  reg  displayed;

  
  initial  
  begin
    state <= STATE_0;
    start_barra <= 1'b0;
    start_ball <= 1'b0;
    displayed <= 0;
    reset_bola <= 1'b0;
    reset_barra <= 1'b0;
    revisar_estado <= 1'b0;
  end
  
  always @(posedge clock or posedge reset)
      begin
        if (reset) 
          begin
            state <= STATE_0;
            start_barra <= 1'b0;
            start_ball <= 1'b0;
            displayed <= 1'b0;
            reset_bola <= 1'b0;
            reset_barra <= 1'b0;
            revisar_estado <= 1'b0;
          end
        else 
          begin
            case (state)

              STATE_0: begin
                    if (start) 
                      begin
                        reset_barra <= 1'b1;
                        reset_bola <= 1'b1;
                        state <= STATE_1;
                      end
                      
                  end

              STATE_1: begin
                    reset_barra <= 1'b0;
                    reset_bola <= 1'b0;
                    revisar_estado <= 1'b1;
                    state <= STATE_2;
                  end

              STATE_2: begin
                    revisar_estado <= 1'b0;
                    state <= STATE_3;
                  end

              STATE_3: begin
                    if (perdio) 
                      begin
                        state <= STATE_0;
                      end
                    else state <= STATE_4;
                  end

              STATE_4: begin
                    if (v_sync) 
                      begin
                        if (!displayed) 
                          begin
                            start_barra <= 1'b1;
                            start_ball <= 1'b1;
                            displayed <= 1'b1;
                            state <= STATE_5;
                          end
                          
                      end
                    else displayed <= 0;
                  end

              STATE_5: begin
                    state <= STATE_6;
                  end

              STATE_6: begin
                    start_barra <= 1'b0;
                    start_ball <= 1'b0;
                    state <= STATE_7;
                  end

              STATE_7: begin
                    if (!busy_barra && !busy_ball) 
                      begin
                        state <= STATE_1;
                      end
                      
                  end

              default: begin
                    state <= STATE_0;
                  end

            endcase

          end
      end
endmodule

