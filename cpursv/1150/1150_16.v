
module VGA_Ctrl(iRed,iGreen,iBlue,oCurrent_X,oCurrent_Y,oAddress,oRequest,
                oVGA_R,oVGA_G,oVGA_B,oVGA_HS,oVGA_VS,oVGA_SYNC,oVGA_BLANK,
                oVGA_CLOCK,iCLK,iRST_N);

  input  [9:0] iRed,iGreen,iBlue;
  output reg [21:0] oAddress;
  output reg [10:0] oCurrent_X,oCurrent_Y;
  output reg oRequest;
  output [9:0] oVGA_R,oVGA_G,oVGA_B;
  output reg oVGA_HS,oVGA_VS;
  output oVGA_SYNC,oVGA_BLANK,oVGA_CLOCK;
  input  iCLK,iRST_N;
  reg  [10:0] H_Cont;
  reg  [10:0] V_Cont;
  parameter  H_FRONT = 16;
  parameter  H_SYNC = 96;
  parameter  H_BACK = 48;
  parameter  H_ACT = 640;
  parameter  H_BLANK = H_SYNC+(H_FRONT+H_BACK);
  parameter  H_TOTAL = H_SYNC+(H_BACK+(H_FRONT+H_ACT));
  parameter  V_FRONT = 11;
  parameter  V_SYNC = 1+1;
  parameter  V_BACK = 31;
  parameter  V_ACT = 480;
  parameter  V_BLANK = V_FRONT+(V_SYNC+V_BACK);
  parameter  V_TOTAL = (V_FRONT+V_SYNC)+(V_ACT+V_BACK);

  assign oVGA_SYNC = 1'b1;
  assign oVGA_BLANK = ~((H_Cont < H_BLANK) || (V_Cont < V_BLANK));
  assign oVGA_CLOCK = ~iCLK;
  assign oVGA_R = iRed;
  assign oVGA_G = iGreen;
  assign oVGA_B = iBlue;
  assign oAddress = (H_ACT*oCurrent_Y)+oCurrent_X;
  assign oRequest = (H_Cont < H_TOTAL) && (V_Cont < V_TOTAL) && 
                    (H_Cont >= H_BLANK) && (V_Cont >= V_BLANK);
  assign oCurrent_X = (H_Cont >= H_BLANK) ? (H_Cont-H_BLANK) : 11'h0;
  assign oCurrent_Y = (V_Cont >= V_BLANK) ? (V_Cont-V_BLANK) : 11'h0;
  
  always @(posedge iCLK or negedge iRST_N)
      begin
        if (!iRST_N) 
          begin
            H_Cont <= 0;
            oVGA_HS <= 1;
          end
        else 
          begin
            if (H_Cont < H_TOTAL) H_Cont <= 1'b1+H_Cont;
            else H_Cont <= 0;
            if (H_Cont == (H_FRONT+(0-1))) oVGA_HS <= 1'b0;
              
            if (H_Cont == (H_SYNC+(H_FRONT+(0-1)))) oVGA_HS <= 1'b1;
              
          end
      end
  
  always @(posedge oVGA_HS or negedge iRST_N)
      begin
        if (!iRST_N) 
          begin
            V_Cont <= 0;
            oVGA_VS <= 1;
          end
        else 
          begin
            if (V_Cont < V_TOTAL) V_Cont <= V_Cont+1'b1;
            else V_Cont <= 0;
            if (V_Cont == (V_FRONT-1)) oVGA_VS <= 1'b0;
              
            if (V_Cont == (V_FRONT+(V_SYNC+(0-1)))) oVGA_VS <= 1'b1;
              
          end
      end
endmodule

