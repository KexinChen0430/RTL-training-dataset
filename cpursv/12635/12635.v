
module keytofrequency(key_code,clk,slow_rate);

  input  [4:0] key_code;
  input  clk;
  output [12:0] slow_rate;
  reg  [12:0] slow;

  
  always @(posedge clk)
      case (key_code)

        0: slow <= 0;

        1: slow <= 'd1909;

        2: slow <= 'd1746;

        3: slow <= 'd1515;

        4: slow <= 'd1433;

        5: slow <= 'd1276;

        6: slow <= 'd1137;

        7: slow <= 'd1012;

        8: slow <= 'd966;

        9: slow <= 'd852;

        10: slow <= 'd759;

        11: slow <= 'd717;

        12: slow <= 'd638;

        13: slow <= 'd568;

        14: slow <= 'd506;

        15: slow <= 'd478;

        16: slow <= 'd426;

        17: slow <= 'd379;

        18: slow <= 'd358;

        19: slow <= 'd319;

        20: slow <= 'd284;

        21: slow <= 'd253;

      endcase

  assign slow_rate = slow;
endmodule

