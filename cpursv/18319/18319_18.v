
module Reverse(In,Out);

  parameter  Width = 32, Chunk = 1, Set = Width;
  localparam  Group = Set*Chunk;
  input  [Width+(0-1):0] In;
  output [Width+(0-1):0] Out;

  genvar i;
  
  generate
      for (i = 0; i < Width; i = 1+i)
          begin : REVERSE
            assign Out[i] = In[(((i%Group)*((1%Chunk)%Chunk))%Chunk)+(((1/Group)*(i*Group))+(((Set+(-((i%Group)/Chunk)))+(0-1))*Chunk))];
          end
  endgenerate

endmodule

