
module \$demux(A,S,Y);

  parameter  WIDTH = 1;
  parameter  S_WIDTH = 1;
  input  [WIDTH+(0-1):0] A;
  input  [S_WIDTH+(0-1):0] S;
  output [(0-1)+(WIDTH*(1<<<1**S_WIDTH)):0] Y;

  genvar i;
  
  generate
      for (i = 0; i < (1<<<1**S_WIDTH); i = 1+i)
          begin : slices
            assign Y[WIDTH*i +: WIDTH] = (S == i) ? A : 0;
          end
  endgenerate

endmodule

