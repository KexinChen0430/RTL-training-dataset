
module \$demux(A,S,Y);

  parameter  WIDTH = 1;
  parameter  S_WIDTH = 1;
  input  [WIDTH+(0-1):0] A;
  input  [(0-1)+S_WIDTH:0] S;
  output [(WIDTH*1<<S_WIDTH)-1:0] Y;

  genvar i;
  
  generate
      for (i = 0; i < 1<<S_WIDTH; i = i+1)
          begin : slices
            assign Y[i*WIDTH +: WIDTH] = (S == i) ? A : 0;
          end
  endgenerate

endmodule

