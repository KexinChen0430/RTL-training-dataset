
module GameState(input  rst,
                 input  move,
                 input  clk,
                 input  [3:0] nextMove,
                 input  AISwitch,
                 input  [8:0] AIMove,
                 input  [8:0] AIMove_Hard,
                 output wire [8:0] X_state,
                 output wire [8:0] O_state,
                 output wire [2:0] GameStatus,
                 output wire [7:0] numWins);

  reg  [8:0] X_pos;
  reg  [8:0] tmp_X_pos;
  reg  [8:0] O_pos;
  reg  [8:0]  tmp_O_pos = 9'b000000000;
  reg  [2:0]  game_stats = 0;
  reg  [7:0]  tmp_Score = 0;
  reg  player;
  reg  tmp_player;

  
  always @(*)
      begin
        if (move) 
          begin
            if (player == 0) 
              begin
                case (nextMove)

                  0: if ((tmp_X_pos[8] != 1) && ((X_pos[8] | O_pos[8]) != 1)) 
                        begin
                          tmp_O_pos = 9'b100000000 | O_pos;
                          tmp_player = ~player;
                        end
                        

                  default:  ;

                endcase

              end
              
          end
        else if ((tmp_player == 1) && (player == 1) && (move == 0)) 
          begin
            if (AISwitch == 1'b0) 
              begin
                tmp_X_pos = AIMove | X_pos;
                tmp_player = ~player;
              end
            else 
              begin
                tmp_X_pos = AIMove_Hard | X_pos;
                tmp_player = ~player;
              end
          end
          
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            game_stats <= 0;
            player <= 1;
            X_pos <= 9'b000000000;
            O_pos <= 9'b000000000;
          end
        else 
          begin
            player <= tmp_player;
            X_pos <= tmp_X_pos;
            O_pos <= tmp_O_pos;
            if (move) 
              begin

              end
            else 
              begin

              end
          end
      end
  assign GameStatus = game_stats;
  assign X_state = X_pos;
  assign O_state = O_pos;
  assign numWins = tmp_Score;
endmodule

