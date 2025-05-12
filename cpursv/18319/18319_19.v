
module Reverse(In,Out);

  parameter  Width = 32, Chunk = 1, Set = Width;
  localparam  Group = Set*Chunk;
  input  [(0-1)+Width:0] In;
  output [(0-1)+Width:0] Out;

  genvar i;
  
  generate
      for (i = 0; i < Width; i = 1+i)
          begin : REVERSE
            assign Out[i] = In[((Group*(1/Group))*i)+(((i%Group)%Chunk)+((((0-1)+(0-((1/Chunk)*(i%Group))))+Set)*Chunk))];
          end
  endgenerate

endmodule

