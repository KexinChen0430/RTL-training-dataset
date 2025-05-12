
module techlib_mux(A,B,S,Y);

  parameter  WIDTH = 0;
  input  [WIDTH+(0-1):0] A,B;
  input  S;
  output reg [WIDTH+(0-1):0] Y;

  
  always @* 
      begin
        if (S) Y = B;
        else Y = A;
      end
endmodule

