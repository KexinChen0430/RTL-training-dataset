
module eth_random(MTxClk,Reset,StateJam,StateJam_q,RetryCnt,NibCnt,ByteCnt,
                  RandomEq0,RandomEqByteCnt);

  parameter  Tp = 1;
  input  MTxClk;
  input  Reset;
  input  StateJam;
  input  StateJam_q;
  input  [3:0] RetryCnt;
  input  [15:0] NibCnt;
  input  [9:0] ByteCnt;
  output RandomEq0;
  output RandomEqByteCnt;
  wire Feedback;
  reg  [9:0] x;
  wire [9:0] Random;
  reg  [9:0] RandomLatched;

  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) x[9:0] <= #Tp 0;
        else x[9:0] <= #Tp {x[8:0],Feedback};
      end
  assign Feedback = ~(x[9] ^ x[2]);
  assign Random[0] = x[0];
  assign Random[1] = (RetryCnt > 1) ? x[1] : 1'b0;
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) RandomLatched <= #Tp 10'h000;
        else 
          begin
            if (StateJam_q & StateJam) RandomLatched <= #Tp Random;
              
          end
      end
  assign RandomEq0 = RandomLatched == 10'h0;
  assign RandomEqByteCnt = ByteCnt[9:0] == (RandomLatched & &NibCnt[6:0]);
endmodule

