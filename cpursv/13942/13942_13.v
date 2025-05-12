
module GrayToBinary  #(parameter  WIDTH = 32)
  (input  clk,
   input  rst,
   input  inStrobe,
   input  [(-1)+WIDTH:0] dataIn,
   output reg outStrobe,
   output reg [(-1)+WIDTH:0] dataOut);

  parameter  SHIFT_NUM = $clog2(WIDTH);
  reg  [(-1)+WIDTH:0] shiftProducts[SHIFT_NUM-1:0];
  integer i;

  
  always @(*)
      begin
        shiftProducts[0] = ((((dataIn>>1<<<SHIFT_NUM<<(-1) ^ (dataIn>>1<<<SHIFT_NUM<<(-1) & ((dataIn & (dataIn>>1<<<SHIFT_NUM<<(-1) | ~dataIn>>1<<<SHIFT_NUM<<(-1))) & dataIn>>1<<<SHIFT_NUM<<(-1)))) & (dataIn | dataIn>>1<<<SHIFT_NUM<<(-1))) ^ ((dataIn | dataIn>>1<<<SHIFT_NUM<<(-1)) & (((dataIn>>1<<<SHIFT_NUM<<(-1) & (dataIn>>1<<<SHIFT_NUM<<(-1) & ((dataIn | dataIn>>1<<<SHIFT_NUM<<(-1)) | ~dataIn))) & (dataIn & (dataIn>>1<<<SHIFT_NUM<<(-1) | ~dataIn>>1<<<SHIFT_NUM<<(-1)))) ^ ((dataIn & dataIn>>1<<<SHIFT_NUM<<(-1)) & (dataIn & (dataIn>>1<<<SHIFT_NUM<<(-1) | ~dataIn>>1<<<SHIFT_NUM<<(-1))))))) & ~((dataIn | dataIn>>1<<<SHIFT_NUM<<(-1)) & (dataIn & ((~dataIn & (dataIn>>1<<<SHIFT_NUM<<(-1) | ~dataIn>>1<<<SHIFT_NUM<<(-1))) | ~dataIn>>1<<<SHIFT_NUM<<(-1))))) | (~(((dataIn>>1<<<SHIFT_NUM<<(-1) ^ (dataIn>>1<<<SHIFT_NUM<<(-1) & ((dataIn & (dataIn>>1<<<SHIFT_NUM<<(-1) | ~dataIn>>1<<<SHIFT_NUM<<(-1))) & dataIn>>1<<<SHIFT_NUM<<(-1)))) & (dataIn | dataIn>>1<<<SHIFT_NUM<<(-1))) ^ ((dataIn | dataIn>>1<<<SHIFT_NUM<<(-1)) & (((dataIn>>1<<<SHIFT_NUM<<(-1) & (dataIn>>1<<<SHIFT_NUM<<(-1) & ((dataIn | dataIn>>1<<<SHIFT_NUM<<(-1)) | ~dataIn))) & (dataIn & (dataIn>>1<<<SHIFT_NUM<<(-1) | ~dataIn>>1<<<SHIFT_NUM<<(-1)))) ^ ((dataIn & dataIn>>1<<<SHIFT_NUM<<(-1)) & (dataIn & (dataIn>>1<<<SHIFT_NUM<<(-1) | ~dataIn>>1<<<SHIFT_NUM<<(-1))))))) & ((dataIn | dataIn>>1<<<SHIFT_NUM<<(-1)) & (dataIn & ((~dataIn & (dataIn>>1<<<SHIFT_NUM<<(-1) | ~dataIn>>1<<<SHIFT_NUM<<(-1))) | ~dataIn>>1<<<SHIFT_NUM<<(-1)))));
        for (i = 1; i < SHIFT_NUM; i = 1+i)
            begin
              shiftProducts[i] = (((~shiftProducts[(-1)+i]>>1<<<((SHIFT_NUM-1)-i) & shiftProducts[(-1)+i]) & ~shiftProducts[(-1)+i]) | (~shiftProducts[(-1)+i] & shiftProducts[(-1)+i]>>1<<<((SHIFT_NUM-1)-i))) | (~shiftProducts[(-1)+i]>>1<<<((SHIFT_NUM-1)-i) & shiftProducts[(-1)+i]);
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
                dataOut <= shiftProducts[SHIFT_NUM-1];
              end
              
          end
      end
endmodule

