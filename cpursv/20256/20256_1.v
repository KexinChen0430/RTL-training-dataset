
module Gato_FSM(clk,reset,state,p1_mm,p2_mm,p1_tie,p1_loss,p1_win,p2_tie,
                p2_loss,p2_win,verifica_status,turno_p1,turno_p2,win_game,
                loss_game,tie_game);

  input  clk,reset;
  input  p1_mm,p2_mm;
  input  p1_tie,p1_loss,p1_win,p2_tie,p2_loss,p2_win;
  output reg turno_p1,turno_p2;
  output reg verifica_status;
  output reg win_game,loss_game,tie_game;
  output [3:0] state;
  reg  [3:0] state,nextState;
  parameter  P1_Move = 0;
  parameter  P1_Status = 1;
  parameter  P2_Move = 2;
  parameter  P2_Status = 3;
  parameter  Win = 4;
  parameter  Tie = 5;
  parameter  Loss = 6;

  
  initial    turno_p1 <= 1'b1;
  
  initial    turno_p2 <= 1'b0;
  
  always @(posedge clk or posedge reset)
      begin
        if (reset) state <= P1_Move;
        else state <= nextState;
      end
  
  always @(state or p1_mm or p2_mm or p1_win or p1_loss or p1_tie or p2_win or p2_loss or p2_tie)
      begin
        nextState = 3'bxxx;
        case (state)

          P1_Move: begin
                verifica_status <= 1'b0;
                turno_p1 <= 1'b1;
                turno_p2 <= 1'b0;
                if (p1_mm == 1'b0) nextState = P1_Move;
                else if (p1_mm == 1'b1) nextState = P1_Status;
                  
              end

        endcase

      end
endmodule

