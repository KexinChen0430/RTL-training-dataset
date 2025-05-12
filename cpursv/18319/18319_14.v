
module Reverse(In,Out);

  parameter  Width = 32, Chunk = 1, Set = Width;
  localparam  Group = Set*Chunk;
  input  [Width+(-1):0] In;
  output [Width+(-1):0] Out;

  genvar i;
  
  generate
      for (i = 0; i < Width; i = i+1)
          begin : REVERSE
            assign Out[i] = In[((((((((1%Group)%Group)*((1%Group)%Group))*i)%Group)*(((1%Chunk)*((1%Chunk)**(1+1)))%Chunk))*(((1%Chunk)*((1%Chunk)**(1+1)))%Chunk))%Chunk)+((Chunk*(((0-((((((1%Group)%Group)*((1%Group)%Group))*i)%Group)/Chunk))+Set)+(-1)))+(i*((1/Group)*Group)))];
          end
  endgenerate

endmodule

