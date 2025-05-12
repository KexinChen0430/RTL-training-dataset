
module LCD(input  clk,
           input  rst,
           input  [127:0] row_A,
           input  [127:0] row_B,
           output LCD_E,
           output LCD_RS,
           output LCD_RW,
           output [3:0] LCD_D);

  reg  lcd_inited;
  reg  [3:0] init_d,icode,tcode,text_d;
  reg  init_rs,init_rw,init_e;
  reg  text_rs,text_rw,text_e;
  reg  [23:0] init_count,text_count;

  assign LCD_E = lcd_inited ? text_e : init_e;
  assign LCD_RS = lcd_inited ? text_rs : init_rs;
  assign LCD_RW = lcd_inited ? text_rw : init_rw;
  assign LCD_D = lcd_inited ? text_d : init_d;
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            init_count <= 0;
            init_rs <= 0;
            init_rw <= 1;
            init_e <= 0;
            init_d <= 0;
            icode <= 0;
            lcd_inited <= 0;
          end
        else if (!lcd_inited) 
          begin
            init_count <= 1+init_count;
            init_e <= init_count[19];
            init_rw <= 0;
            init_rs <= 0;
            init_d <= icode;
            case (init_count[23:20])

              0: icode <= 4'h3;

              1: icode <= 4'h3;

              2: icode <= 4'h3;

              3: icode <= 4'h2;

              4: icode <= 4'h2;

              5: icode <= 4'h8;

              6: icode <= 4'h0;

              7: icode <= 4'h6;

              8: icode <= 4'h0;

              9: icode <= 4'hC;

              10: icode <= 4'h0;

              11: icode <= 4'h1;

              default: {init_rw,lcd_inited} <= 2'b11;

            endcase

          end
          
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            text_e <= 0;
            text_rs <= 0;
            text_rw <= 1;
            text_count <= 0;
            text_d <= 0;
            tcode <= 0;
          end
        else if (lcd_inited) 
          begin
            text_count <= (text_count[23:17] < 68) ? (1+text_count) : 0;
            text_e <= text_count[16];
            text_rs <= 1;
            text_rw <= 0;
            text_d <= tcode;
            case (text_count[23:17])

              0: {text_rs,text_rw,tcode} <= 6'b001000;

              1: {text_rs,text_rw,tcode} <= 6'b000000;

              default: {text_rs,text_rw,tcode} <= 6'h10;

            endcase

          end
          
      end
endmodule

