
module Reverse(In,Out);

  parameter  Width = 32, Chunk = 1, Set = Width;
  localparam  Group = Set*Chunk;
  input  [(-1)+Width:0] In;
  output [(-1)+Width:0] Out;

  genvar i;
  
  generate
      for (i = 0; i < Width; i = 1+i)
          begin : REVERSE
            assign Out[i] = In[(((1/Group)*(Group*i))+((((-1)+Set)-(((((1%Group)%Group)*i)%Group)/Chunk))*Chunk))+(((((1%Group)%Group)*i)%Group)%Chunk)];
          end
  endgenerate

endmodule

