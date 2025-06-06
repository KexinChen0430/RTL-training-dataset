
module GrayToBinary  #(parameter  WIDTH = 32)
  (input  clk,
   input  rst,
   input  inStrobe,
   input  [WIDTH+(0-1):0] dataIn,
   output reg outStrobe,
   output reg [WIDTH+(0-1):0] dataOut);

  parameter  SHIFT_NUM = $clog2(WIDTH);
  reg  [WIDTH+(0-1):0] shiftProducts[SHIFT_NUM+(0-1):0];
  integer i;

  
  always @(*)
      begin
        shiftProducts[0] = (dataIn>>(2**(SHIFT_NUM+(0-1))) & ((~dataIn>>(2**(SHIFT_NUM+(0-1))) | ~dataIn) | dataIn)) ^ (((dataIn>>(2**(SHIFT_NUM+(0-1))) | ~dataIn>>(2**(SHIFT_NUM+(0-1)))) & dataIn) & ((~dataIn>>(2**(SHIFT_NUM+(0-1))) | ~dataIn) | dataIn));
        for (i = 1; i < SHIFT_NUM; i = 1+i)
            begin
              shiftProducts[i] = ((((~shiftProducts[(0-1)+i] | shiftProducts[(0-1)+i]) | ((((shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i) | ~shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i)) & shiftProducts[(0-1)+i]) & ~shiftProducts[(0-1)+i]) | (shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i) & ~shiftProducts[(0-1)+i]))) & shiftProducts[(0-1)+i]) & (~shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i) | ((((shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i) | ~shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i)) & shiftProducts[(0-1)+i]) & ~shiftProducts[(0-1)+i]) | (shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i) & ~shiftProducts[(0-1)+i])))) ^ ((~shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i) | ((((shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i) | ~shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i)) & shiftProducts[(0-1)+i]) & ~shiftProducts[(0-1)+i]) | (shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i) & ~shiftProducts[(0-1)+i]))) & (((~shiftProducts[(0-1)+i] | shiftProducts[(0-1)+i]) | ((((shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i) | ~shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i)) & shiftProducts[(0-1)+i]) & ~shiftProducts[(0-1)+i]) | (shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i) & ~shiftProducts[(0-1)+i]))) & shiftProducts[(0-1)+i]>>(2**(SHIFT_NUM+(0-1)))<<(-i)));
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
                dataOut <= shiftProducts[SHIFT_NUM+(0-1)];
              end
              
          end
      end
endmodule

