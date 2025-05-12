
module Counter(input  clk,
               input  enable,
               output reg [1+1:0] count);

  
  initial    count = 3'b110;
  
  always @(posedge clk)
      begin
        if (enable) count = (-1'b1)+count;
          
        if (count == 3'b111) count = 3'b110;
          
      end
endmodule

