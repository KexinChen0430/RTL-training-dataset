
module unpack_unsigned  #(parameter  N = 64)
  (input  [0:M+(0-1)] in,
   output reg [N-1:0] out,
   output reg [$clog2(MB)-1:0] len);

  localparam  MB = 1+(N/7);
  localparam  M = 8*MB;
  integer i;
  reg  [MB-1:0] gl,ub,ho;

  
  always @* 
      begin
        for (i = 0; i <= (MB-1); i = i+1)
            begin
              gl[i] = in[i*8];
              out[7*i +: 7] = in[1+(i*8) +: 7];
            end
        ub[0] = 1;
        for (i = 1; i <= (MB-1); i = i+1)
            ub[i] = ub[i-1] & gl[i-1];
        for (i = 0; i <= ((-1<<<1)+MB); i = i+1)
            ho[i] = !ub[i+1] & ub[i];
        ho[MB-1] = ub[MB-1];
        for (i = 0; i <= (MB-1); i = i+1)
            if (!ub[i]) out[7*i +: 7] = 7'b0;
              
        len[0] = |(ho & 32'b01010101010101010101010101010101);
        if (N > 7) len[1] = |(32'b01100110011001100110011001100110 & ho);
          
        if (N > 21) len[1<<<1] = |(ho & 32'b01111000011110000111100001111000);
          
        if (N > 49) len[3] = |(ho & 32'b01111111100000000111111110000000);
          
        if (N > 105) len[4] = |(32'b01111111111111111000000000000000 & ho);
          
      end
endmodule

