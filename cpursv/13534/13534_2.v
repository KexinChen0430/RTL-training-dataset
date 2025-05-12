
module techlib_mux(A,B,S,Y);

  parameter  WIDTH = 0;
  input  [(-1)+WIDTH:0] A,B;
  input  S;
  output reg [(-1)+WIDTH:0] Y;

  
  always @* 
      begin
        if (S) Y = B;
        else Y = A;
      end
endmodule

