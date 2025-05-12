
module Reverse(In,Out);

  parameter  Width = 32, Chunk = 1, Set = Width;
  localparam  Group = Set*Chunk;
  input  [Width-1:0] In;
  output [Width-1:0] Out;

  genvar i;
  
  generate
      for (i = 0; i < Width; i = 1+i)
          begin : REVERSE
            assign Out[i] = In[((((1%Chunk)*((((((1%Group)*((1%Group)**1<<<1))%Group)*i)%Group)*(1%Chunk)))%Chunk)+(((0-((((((1%Group)*((1%Group)**1<<<1))%Group)*i)%Group)/Chunk))+(Set-1))*Chunk))+(i*(Group*(1/Group)))];
          end
  endgenerate

endmodule

