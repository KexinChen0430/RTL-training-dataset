
module state_control(input  CLK,
                     input  START,
                     input  RESET,
                     input  BTN_PLAYER1,
                     input  BTN_PLAYER2,
                     input  [3:0] iSW,
                     output [7:0] OLED,
                     output reg [8:0] occupied,
                     output reg [8:0] symbol);

  localparam  IDLE = 2'd0;
  localparam  PLAYER1 = 2'd1;
  localparam  PLAYER2 = 2'd2;
  localparam  FINISH = 2'd3;
  localparam  NO_WIN = 2'd0;
  localparam  PLAYER1_WIN = 2'd1;
  localparam  PLAYER2_WIN = 2'd2;
  localparam  DRAW_GAME = 2'd3;
  reg  [1:0] WIN,state;
  reg  [1:0] next_win,next_state;

  assign OLED = {WIN,4'b0,state};
  
  always @(posedge CLK)
      begin
        if (RESET) 
          begin
            state <= IDLE;
            WIN <= NO_WIN;
          end
        else 
          begin
            state <= next_state;
            WIN <= next_win;
          end
      end
  reg  py1_draw,py2_draw;

  
  always @(*)
      begin
        if ((iSW <= 9) && (~occupied[(-1)+iSW] && (iSW > 0))) 
          begin
            py1_draw = BTN_PLAYER1;
            py2_draw = BTN_PLAYER2;
          end
        else 
          begin
            py1_draw = 1'b0;
            py2_draw = 1'b0;
          end
      end
  
  always @(posedge CLK)
      begin
        if (RESET) 
          begin
            occupied = 9'b0;
            symbol = 9'b0;
          end
        else if ((iSW > 0) && (iSW <= 9)) 
          begin
            if (py1_draw && (state == PLAYER1)) 
              begin
                occupied[(-1)+iSW] = 1'b1;
                symbol[(-1)+iSW] = 1'b0;
              end
            else if ((state == PLAYER2) && py2_draw) 
              begin
                occupied[(-1)+iSW] = 1'b1;
                symbol[(-1)+iSW] = 1'b1;
              end
              
          end
          
      end
  reg  [8:0] next_occupied,next_symbol;

  
  always @(*)
      begin
        next_occupied = occupied;
        next_symbol = symbol;
        if (
(((state == PLAYER2) && py2_draw) || 
(
(py1_draw && (state == PLAYER1) && (state == PLAYER2)) || 
(
(py2_draw || 
((py2_draw || (state == PLAYER1)) && py1_draw)) && py1_draw))) && 
            (
(
((py1_draw && (state == PLAYER1)) || 
((state == PLAYER2) && py1_draw)) && py1_draw) || (state == PLAYER2) || (state == PLAYER1))) next_occupied = occupied | 1'b1<<iSW<<<(-1'b1);
          
        if ((state == PLAYER2) && py2_draw) next_symbol = 1'b1<<iSW<<<(-1'b1) | symbol;
          
      end
  
  always @(*)
      begin
        if (WIN == PLAYER1_WIN) next_win = PLAYER1_WIN;
        else if (WIN == PLAYER2_WIN) next_win = PLAYER2_WIN;
        else if (WIN == DRAW_GAME) next_win = DRAW_GAME;
        else 
          begin
            next_win = NO_WIN;
            if (
(((state == PLAYER2) && py2_draw) || 
(
(py1_draw && (state == PLAYER1) && (state == PLAYER2)) || 
(
(py2_draw || 
((py2_draw || (state == PLAYER1)) && py1_draw)) && py1_draw))) && 
                (
(
((py1_draw && (state == PLAYER1)) || 
((state == PLAYER2) && py1_draw)) && py1_draw) || (state == PLAYER2) || (state == PLAYER1))) 
              begin

              end
              
          end
      end
  
  always @(*)
      begin
        case (state)

          IDLE: if (START) next_state = PLAYER1;
              else next_state = IDLE;

          PLAYER1: if (py1_draw) 
                if (next_win) next_state = FINISH;
                else next_state = PLAYER2;
              else next_state = PLAYER1;

          PLAYER2: if (py2_draw) 
                if (next_win) next_state = FINISH;
                else next_state = PLAYER1;
              else next_state = PLAYER2;

          default: next_state = FINISH;

        endcase

      end
endmodule

