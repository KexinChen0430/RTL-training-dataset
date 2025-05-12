
module GrayToBinary  #(parameter  WIDTH = 32)
  (input  clk,
   input  rst,
   input  inStrobe,
   input  [(0-1)+WIDTH:0] dataIn,
   output reg outStrobe,
   output reg [(0-1)+WIDTH:0] dataOut);

  parameter  SHIFT_NUM = $clog2(WIDTH);
  reg  [(0-1)+WIDTH:0] shiftProducts[(0-1)+SHIFT_NUM:0];
  integer i;

  
  always @(*)
      begin
        shiftProducts[0] = ((dataIn & (~dataIn>>(1<<(0-1)*1<<SHIFT_NUM) | (dataIn | dataIn>>(1<<(0-1)*1<<SHIFT_NUM)))) & (((dataIn | dataIn>>(1<<(0-1)*1<<SHIFT_NUM)) & ~dataIn) | (dataIn | ~dataIn))) ^ ((((dataIn | dataIn>>(1<<(0-1)*1<<SHIFT_NUM)) & ~dataIn) | (dataIn | ~dataIn)) & dataIn>>(1<<(0-1)*1<<SHIFT_NUM));
        for (i = 1; i < SHIFT_NUM; i = 1+i)
            begin
              shiftProducts[i] = ((~shiftProducts[i-1] | (~shiftProducts[i-1]>>1<<SHIFT_NUM<<<((0-1)+(0-i)) & shiftProducts[i-1]>>1<<SHIFT_NUM<<<((0-1)+(0-i)))) | ~shiftProducts[i-1]>>1<<SHIFT_NUM<<<((0-1)+(0-i))) & (shiftProducts[i-1]>>1<<SHIFT_NUM<<<((0-1)+(0-i)) | shiftProducts[i-1]);
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

