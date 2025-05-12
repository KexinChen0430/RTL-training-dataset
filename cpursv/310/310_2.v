
module LCD(input  clk,
           input  rst,
           input  [127:0] upRow,
           input  [127:0] doRow,
           output e,
           output rs,
           output rw,
           output [3:0] sf);

  reg  [23:0]  count = 0;
  reg  refresh;
  reg  [5:0] Code;

  assign {e,rs,rw,sf} = {refresh,Code};
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) count <= count;
        else count <= (count[23:17] < 78) ? (count+1) : 0;
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) Code <= 6'h10;
        else 
          begin
            case (count[23:17])

              0: Code <= 6'h03;

              1: Code <= 6'h03;

              2: Code <= 6'h03;

              3: Code <= 6'h02;

              4: Code <= 6'h02;

              5: Code <= 6'h08;

              6: Code <= 6'h00;

              7: Code <= 6'h06;

              8: Code <= 6'h00;

              9: Code <= 6'h0C;

              10: Code <= 6'h00;

              11: Code <= 6'h01;

              12: Code <= {2'b10,upRow[127:124]};

              43: Code <= {2'b10,upRow[3:0]};

              44: Code <= 6'b001100;

              45: Code <= 6'b000000;

              46: Code <= {2'b10,doRow[127:124]};

              77: Code <= {2'b10,doRow[3:0]};

              default: Code <= 6'h10;

            endcase

          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) refresh <= 1;
        else refresh <= count[16];
      end
endmodule

