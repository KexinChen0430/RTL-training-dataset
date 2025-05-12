
module Reverse(In,Out);

  parameter  Width = 32, Chunk = 1, Set = Width;
  localparam  Group = Chunk*Set;
  input  [(0-1)+Width:0] In;
  output [(0-1)+Width:0] Out;

  genvar i;
  
  generate
      for (i = 0; i < Width; i = i+1)
          begin : REVERSE
            assign Out[i] = In[((((i*(((((1%Group)*(1%Group))*(1%Group))%Group)**2))%Group)%Chunk)+((Set+((0-(((i*(((((1%Group)*(1%Group))*(1%Group))%Group)**2))%Group)/Chunk))+(0-1)))*Chunk))+(Group*((1/Group)*i))];
          end
  endgenerate

endmodule

