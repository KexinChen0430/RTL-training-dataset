
module Reverse(In,Out);

  parameter  Width = 32, Chunk = 1, Set = Width;
  localparam  Group = Set*Chunk;
  input  [(-1)+Width:0] In;
  output [(-1)+Width:0] Out;

  genvar i;
  
  generate
      for (i = 0; i < Width; i = i+1)
          begin : REVERSE
            assign Out[i] = In[((((1%Chunk)*(1%Chunk))*(((((1%Group)%Group)*((1%Group)%Group))*(i*((1%Group)%Group)))%Group))%Chunk)+(((1/Group)*(Group*i))+(Chunk*((-((((((1%Group)%Group)*((1%Group)%Group))*(i*((1%Group)%Group)))%Group)/Chunk))+((-1)+Set))))];
          end
  endgenerate

endmodule

