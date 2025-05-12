
module \$demux(A,S,Y);

  parameter  WIDTH = 1;
  parameter  S_WIDTH = 1;
  input  [WIDTH-1:0] A;
  input  [S_WIDTH-1:0] S;
  output [(1<<S_WIDTH*WIDTH)-1:0] Y;

  genvar i;
  
  generate
      for (i = 0; i < 1<<S_WIDTH; i = 1+i)
          begin : slices
            assign Y[i*WIDTH +: WIDTH] = (S == i) ? A : 0;
          end
  endgenerate

endmodule

