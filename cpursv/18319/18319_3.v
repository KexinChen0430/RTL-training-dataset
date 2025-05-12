
module Reverse(In,Out);

  parameter  Width = 32, Chunk = 1, Set = Width;
  localparam  Group = Chunk*Set;
  input  [Width-1:0] In;
  output [Width-1:0] Out;

  genvar i;
  
  generate
      for (i = 0; i < Width; i = 1+i)
          begin : REVERSE
            assign Out[i] = In[(((1/Group)*(Group*i))+(Chunk*(((-1)+(0-((1/Chunk)*((((1%Group)**1<<1)*i)%Group))))+Set)))+(((((((1%Chunk)**1<<1)*(1%Chunk))%Chunk)*((((1%Group)**1<<1)*i)%Group))*((((1%Chunk)**1<<1)*(1%Chunk))%Chunk))%Chunk)];
          end
  endgenerate

endmodule

