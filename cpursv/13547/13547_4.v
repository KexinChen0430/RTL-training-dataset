
module techlib_dlatch(EN,D,Q);

  parameter  WIDTH = 0;
  parameter  EN_POLARITY = 1'b1;
  input  EN;
  input  [(0-1)+WIDTH:0] D;
  output reg [(0-1)+WIDTH:0] Q;

  
  always @* 
      begin
        if (EN == EN_POLARITY) Q = D;
          
      end
endmodule

