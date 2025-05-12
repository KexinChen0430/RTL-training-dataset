
module Reverse(In,Out);

  parameter  Width = 32, Chunk = 1, Set = Width;
  localparam  Group = Set*Chunk;
  input  [Width+(-1):0] In;
  output [Width+(-1):0] Out;

  genvar i;
  
  generate
      for (i = 0; i < Width; i = i+1)
          begin : REVERSE
            assign Out[i] = In[(((1/Group)*(i*Group))+(((i*((1%Group)%Group))%Group)%Chunk))+((((-((1/Chunk)*((i*((1%Group)%Group))%Group)))+(-1))+Set)*Chunk)];
          end
  endgenerate

endmodule

