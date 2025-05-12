
module GrayToBinary  #(parameter  WIDTH = 32)
  (input  clk,
   input  rst,
   input  inStrobe,
   input  [WIDTH+(0-1):0] dataIn,
   output reg outStrobe,
   output reg [WIDTH+(0-1):0] dataOut);

  parameter  SHIFT_NUM = $clog2(WIDTH);
  reg  [WIDTH+(0-1):0] shiftProducts[(0-1)+SHIFT_NUM:0];
  integer i;

  
  always @(*)
      begin
        shiftProducts[0] = ((~dataIn>>1<<SHIFT_NUM<<<(0-1) | (dataIn>>1<<SHIFT_NUM<<<(0-1) | dataIn)) & dataIn) ^ ((dataIn>>1<<SHIFT_NUM<<<(0-1) & (dataIn | ~dataIn)) & (~dataIn>>1<<SHIFT_NUM<<<(0-1) | (dataIn>>1<<SHIFT_NUM<<<(0-1) | dataIn)));
        for (i = 1; i < SHIFT_NUM; i = i+1)
            begin
              shiftProducts[i] = shiftProducts[(0-1)+i]>>1<<SHIFT_NUM<<<(0-1)<<<(0-i) ^ (shiftProducts[(0-1)+i] & (shiftProducts[(0-1)+i]>>1<<SHIFT_NUM<<<(0-1)<<<(0-i) | ~shiftProducts[(0-1)+i]>>1<<SHIFT_NUM<<<(0-1)<<<(0-i)));
            end
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            outStrobe <= 1'b0;
            dataOut <= 'd0;
          end
        else 
          begin
            outStrobe <= inStrobe;
            if (inStrobe) 
              begin
                dataOut <= shiftProducts[(0-1)+SHIFT_NUM];
              end
              
          end
      end
endmodule

