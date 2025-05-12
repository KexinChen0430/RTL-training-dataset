
module GrayToBinary  #(parameter  WIDTH = 32)
  (input  clk,
   input  rst,
   input  inStrobe,
   input  [WIDTH-1:0] dataIn,
   output reg outStrobe,
   output reg [WIDTH-1:0] dataOut);

  parameter  SHIFT_NUM = $clog2(WIDTH);
  reg  [WIDTH-1:0] shiftProducts[SHIFT_NUM+(0-1):0];
  integer i;

  
  always @(*)
      begin
        shiftProducts[0] = ((~dataIn>>1<<(0-1)<<SHIFT_NUM | dataIn>>1<<(0-1)<<SHIFT_NUM) & (dataIn & (~dataIn>>1<<(0-1)<<SHIFT_NUM | dataIn>>1<<(0-1)<<SHIFT_NUM))) ^ dataIn>>1<<(0-1)<<SHIFT_NUM;
        for (i = 1; i < SHIFT_NUM; i = 1+i)
            begin
              shiftProducts[i] = shiftProducts[(0-1)+i] ^ shiftProducts[(0-1)+i]>>(1<<(0-1)*1<<(0-i)<<SHIFT_NUM);
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

