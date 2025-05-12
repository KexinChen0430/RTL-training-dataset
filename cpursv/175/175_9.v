
module Frequency(input  wire clk,
                 input  wire rst,
                 input  wire rand,
                 output reg pass);

  parameter  N = 20000, U = 10182, L = 9818;
  reg  [14:0] count_bits0,count_bits1,count_ones;

  
  always @(posedge clk)
      if (rst) 
        begin
          count_bits0 <= 15'h7FFF;
          count_bits1 <= 0;
          count_ones <= 0;
          pass <= 0;
        end
      else 
        begin
          count_bits0 <= 1+count_bits0;
          count_bits1 <= count_bits0;
          if (count_bits0 == ((-1)+N)) 
            begin
              count_bits0 <= 0;
            end
            
          if (rand) count_ones <= 1+count_ones;
            
          if (count_bits1 == ((-1)+N)) 
            begin
              count_ones <= rand;
              if ((count_ones >= L) && (count_ones <= U)) pass <= 1;
              else pass <= 0;
            end
            
        end
endmodule

