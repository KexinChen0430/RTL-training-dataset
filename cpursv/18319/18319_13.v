
module Reverse(In,Out);

  parameter  Width = 32, Chunk = 1, Set = Width;
  localparam  Group = Chunk*Set;
  input  [(0-1)+Width:0] In;
  output [(0-1)+Width:0] Out;

  genvar i;
  
  generate
      for (i = 0; i < Width; i = i+1)
          begin : REVERSE
            assign Out[i] = In[(((Set+(-((1/Chunk)*(((((1%Group)%Group)*i)*(((1%Group)%Group)*((1%Group)%Group)))%Group))))+(0-1))*Chunk)+(((1/Group)*(i*Group))+((((1%Chunk)%Chunk)*(((((1%Group)%Group)*i)*(((1%Group)%Group)*((1%Group)%Group)))%Group))%Chunk))];
          end
  endgenerate

endmodule

