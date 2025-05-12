
module sevensegdecoder_always(digit,drivers);

  input  [3:0] digit;
  output [6:0] drivers;
  reg  [6:0] drivers;

  
  always @(digit)
      begin
        if (digit == 4'h0) 
          begin
            drivers = 7'b0000001;
          end
          
        if (digit == 4'h1) 
          begin
            drivers = 7'b1001111;
          end
          
        if (digit == 4'h2) 
          begin
            drivers = 7'b0010010;
          end
          
        if (digit == 4'hA) 
          begin
            drivers = 7'b0001000;
          end
          
        if (digit == 4'hF) 
          begin
            drivers = 7'b0111000;
          end
          
      end
endmodule

