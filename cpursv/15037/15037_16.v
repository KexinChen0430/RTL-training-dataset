
module unpack_unsigned  #(parameter  N = 64)
  (input  [0:(-1)+M] in,
   output reg [N-1:0] out,
   output reg [(-1)+$clog2(MB):0] len);

  localparam  MB = 1+(N/7);
  localparam  M = 8*MB;
  integer i;
  reg  [(-1)+MB:0] gl,ub,ho;

  
  always @* 
      begin
        for (i = 0; i <= ((-1)+MB); i = 1+i)
            begin
              gl[i] = in[i*8];
              out[i*7 +: 7] = in[(i*8)+1 +: 7];
            end
        ub[0] = 1;
        for (i = 1; i <= ((-1)+MB); i = 1+i)
            ub[i] = ub[i-1] & gl[i-1];
        for (i = 0; i <= ((-2)+MB); i = 1+i)
            ho[i] = ub[i] & !ub[1+i];
        ho[(-1)+MB] = ub[(-1)+MB];
        for (i = 0; i <= ((-1)+MB); i = 1+i)
            if (!ub[i]) out[i*7 +: 7] = 7'b0;
              
        len[0] = |(32'b01010101010101010101010101010101 & ho);
        if (N > 7) len[1] = |(ho & 32'b01100110011001100110011001100110);
          
        if (N > 21) len[2] = |(ho & 32'b01111000011110000111100001111000);
          
        if (N > 49) len[3] = |(32'b01111111100000000111111110000000 & ho);
          
        if (N > 105) len[4] = |(ho & 32'b01111111111111111000000000000000);
          
      end
endmodule

