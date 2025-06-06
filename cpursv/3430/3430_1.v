
module LCD_DISPLAY(LCD_ENABLE,LCD_RW,LCD_DI,LCD_CS1,LCD_CS2,LCD_RST,LCD_DATA,
                   CLEAR,CALLFORPATTERN,PATTERN,reset,clk);

  input  clk;
  input  reset;
  input  [255:0] PATTERN;
  output LCD_ENABLE;
  output LCD_RW;
  output LCD_DI;
  output LCD_CS1;
  output LCD_CS2;
  output LCD_RST;
  output [7:0] LCD_DATA;
  output CALLFORPATTERN,CLEAR;
  reg  [7:0] LCD_DATA;
  reg  [1:0] LCD_SEL;
  reg  [2:0] STATE;
  reg  [2:0] X_PAGE;
  reg  [1:0] DELAY;
  reg  [7:0] INDEX;
  reg  [1:0] ENABLE;
  reg  CLEAR;
  reg  LCD_RW;
  reg  LCD_DI;
  reg  LCD_RST;
  reg  CALLFORPATTERN;
  wire clk;
  wire LCD_CS1;
  wire LCD_CS2;
  wire LCD_ENABLE;

  
  always @(negedge clk or negedge reset)
      begin
        if (!reset) 
          begin
            CLEAR = 1'b1;
            STATE = 3'b0;
            DELAY = 2'b00;
            X_PAGE = 3'o0;
            INDEX = 8'd0;
            LCD_DATA = 8'd0;
            LCD_RST = 1'b0;
            ENABLE = 2'b00;
            LCD_SEL = 2'b11;
            LCD_DI = 1'b0;
            LCD_RW = 1'b0;
            CALLFORPATTERN = 0;
          end
        else 
          begin
            if (ENABLE < 2'b10) 
              begin
                ENABLE = ENABLE+2'b1;
                DELAY[1] = 1'b1;
                CALLFORPATTERN = 0;
              end
            else if (DELAY != 2'b00) 
              begin
                DELAY = DELAY+(-2'b1);
              end
            else if (STATE == 3'o0) 
              begin
                LCD_RST = 1'b1;
                LCD_DATA = 8'h3F;
                ENABLE = 2'b00;
                STATE = 3'o1;
              end
            else if (STATE == 3'o1) 
              begin
                LCD_DATA = {2'b11,6'b000000};
                ENABLE = 2'b00;
                STATE = 3'o2;
              end
            else if (STATE == 3'o2) 
              begin
                LCD_DATA = 8'h40;
                ENABLE = 2'b00;
                STATE = 3'o3;
              end
            else if (STATE == 3'o3) 
              begin
                LCD_DI = 1'b0;
                INDEX = 8'hFF;
                 ;
                LCD_DATA = {5'b10111,X_PAGE};
                STATE = 3'o4;
                ENABLE = 2'b00;
                if (CLEAR) CALLFORPATTERN = 0;
                else CALLFORPATTERN = 1;
              end
            else if (STATE == 3'o4) 
              begin
                if (CLEAR) 
                  begin
                    LCD_SEL = 2'b11;
                    if ((INDEX == 8'hFF) || (INDEX < 8'd63)) 
                      begin
                        LCD_DI = 1'b1;
                        INDEX = INDEX+8'd1;
                        LCD_DATA = 8'h00;
                        ENABLE = 2'b00;
                      end
                    else if (X_PAGE < 3'o7) 
                      begin
                        X_PAGE = 3'o1+X_PAGE;
                        STATE = 3'o3;
                      end
                    else 
                      begin
                        X_PAGE = 3'o0;
                        STATE = 3'o3;
                        CLEAR = 1'b0;
                      end
                  end
                else 
                  begin
                    LCD_SEL = 2'b01;
                    if ((INDEX == 8'hFF) || (INDEX < 8'd63)) 
                      begin
                        LCD_DI = 1'b1;
                        INDEX = INDEX+8'h1;
                        if (INDEX < 8'd32) 
                          begin
                            LCD_DATA[7:0] = PATTERN[(0-1)+((INDEX+1)*8) -: 8];
                          end
                        else 
                          begin
                            LCD_DATA[7:0] = PATTERN[((INDEX-8'd31)*8)+(0-1) -: 8];
                          end
                        ENABLE = 2'b00;
                      end
                    else if (X_PAGE < 3'd7) 
                      begin
                        LCD_SEL = 2'b11;
                        X_PAGE = 3'o1+X_PAGE;
                        LCD_DI = 1'b0;
                        INDEX = 8'hFF;
                        LCD_DATA = {5'b10111,X_PAGE};
                        STATE = 3'o4;
                        ENABLE = 2'b00;
                      end
                    else 
                      begin
                        X_PAGE = 3'o1+X_PAGE;
                        LCD_SEL = 2'b11;
                        LCD_DI = 1'b0;
                        INDEX = 8'hFF;
                        LCD_DATA = {5'b10111,X_PAGE};
                        STATE = 3'o5;
                        ENABLE = 2'b00;
                      end
                    if ((INDEX == 8'd31) || (INDEX == 8'hFF)) CALLFORPATTERN = 1;
                    else CALLFORPATTERN = 0;
                  end
              end
            else if (STATE == 3'o5) 
              begin
                LCD_SEL = 2'b10;
                if ((INDEX == 8'hFF) || (INDEX < 8'd63)) 
                  begin
                    LCD_DI = 1'b1;
                    INDEX = INDEX+8'h1;
                    if (INDEX < 8'd32) 
                      begin
                        LCD_DATA[7:0] = PATTERN[(0-1)+((INDEX+1)*8) -: 8];
                      end
                    else 
                      begin
                        LCD_DATA[7:0] = PATTERN[((INDEX-8'd31)*8)+(0-1) -: 8];
                      end
                    ENABLE = 2'b00;
                  end
                else if (X_PAGE < 3'd7) 
                  begin
                    LCD_SEL = 2'b11;
                    X_PAGE = 3'o1+X_PAGE;
                    LCD_DI = 1'b0;
                    INDEX = 8'hFF;
                    LCD_DATA = {5'b10111,X_PAGE};
                    STATE = 3'o5;
                    ENABLE = 2'b00;
                  end
                else 
                  begin
                    LCD_SEL = 2'b11;
                    X_PAGE = 3'o0;
                    STATE = 3'o3;
                  end
                if ((INDEX == 8'd31) || (INDEX == 8'hFF)) CALLFORPATTERN = 1;
                else CALLFORPATTERN = 0;
              end
              
          end
      end
  assign LCD_ENABLE = ENABLE[0];
  assign LCD_CS1 = LCD_SEL[0];
  assign LCD_CS2 = LCD_SEL[1];
endmodule

