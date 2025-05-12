
module GrayToBinary  #(parameter  WIDTH = 32)
  (input  clk,
   input  rst,
   input  inStrobe,
   input  [(0-1)+WIDTH:0] dataIn,
   output reg outStrobe,
   output reg [(0-1)+WIDTH:0] dataOut);

  parameter  SHIFT_NUM = $clog2(WIDTH);
  reg  [(0-1)+WIDTH:0] shiftProducts[SHIFT_NUM+(0-1):0];
  integer i;

  
  always @(*)
      begin
        shiftProducts[0] = dataIn ^ dataIn>>(2**(0-1))<<SHIFT_NUM;
        for (i = 1; i < SHIFT_NUM; i = i+1)
            begin
              shiftProducts[i] = (shiftProducts[i+(0-1)]>>1<<(0-i)<<(SHIFT_NUM+(0-1)) | ((~shiftProducts[i+(0-1)]>>1<<(0-i)<<(SHIFT_NUM+(0-1)) | ~shiftProducts[i+(0-1)]) & ((shiftProducts[i+(0-1)]>>1<<(0-i)<<(SHIFT_NUM+(0-1)) | ~shiftProducts[i+(0-1)]>>1<<(0-i)<<(SHIFT_NUM+(0-1))) & shiftProducts[i+(0-1)]))) & (~shiftProducts[i+(0-1)]>>1<<(0-i)<<(SHIFT_NUM+(0-1)) | ~shiftProducts[i+(0-1)]);
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

