
module JudgeBit(NumIn,Num);

  input  [31:0] NumIn;
  output reg [31:0] Num;
  integer  i = 0;

  
  always @(NumIn)
      begin
        Num = 32;
        for (i = 31; i >= 0; i = i-1)
            if ((Num == 32) && (NumIn[i] == 1'b1)) Num = (-i)+31;
              
      end
endmodule

