
module techlib_dlatch(EN,D,Q);

  parameter  WIDTH = 0;
  parameter  EN_POLARITY = 1'b1;
  input  EN;
  input  [WIDTH+(0-1):0] D;
  output reg [WIDTH+(0-1):0] Q;

  
  always @* 
      begin
        if (EN == EN_POLARITY) Q = D;
          
      end
endmodule

