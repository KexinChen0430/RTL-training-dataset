
module JudgeBit(NumIn,Num);

  input  [31:0] NumIn;
  output reg [31:0] Num;
  integer  i = 0;

  
  always @(NumIn)
      begin
        Num = 32;
        for (i = 31; i >= 0; i = (0-1)+i)
            if ((Num == 32) && (NumIn[i] == 1'b1)) Num = 31+(0-i);
              
      end
endmodule

