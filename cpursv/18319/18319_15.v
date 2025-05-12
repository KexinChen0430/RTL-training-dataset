
module Reverse(In,Out);

  parameter  Width = 32, Chunk = 1, Set = Width;
  localparam  Group = Set*Chunk;
  input  [(-1)+Width:0] In;
  output [(-1)+Width:0] Out;

  genvar i;
  
  generate
      for (i = 0; i < Width; i = 1+i)
          begin : REVERSE
            assign Out[i] = In[((((((1%Group)%Group)*((1%Group)%Group))*(i*((1%Group)%Group)))%Group)%Chunk)+(((i/Group)*Group)+(Chunk*((Set+(-1))-((((((1%Group)%Group)*((1%Group)%Group))*(i*((1%Group)%Group)))%Group)/Chunk))))];
          end
  endgenerate

endmodule

