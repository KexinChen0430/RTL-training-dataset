
module unpack_unsigned  #(parameter  N = 64)
  (input  [0:M+(0-1)] in,
   output reg [N-1:0] out,
   output reg [$clog2(MB)-1:0] len);

  localparam  MB = 1+((1/7)*N);
  localparam  M = MB*8;
  integer i;
  reg  [MB-1:0] gl,ub,ho;

  
  always @* 
      begin
        for (i = 0; i <= (MB-1); i = i+1)
            begin
              gl[i] = in[8*i];
              out[i*7 +: 7] = in[1+(8*i) +: 7];
            end
        ub[0] = 1;
        for (i = 1; i <= (MB-1); i = i+1)
            ub[i] = ub[i-1] & gl[i-1];
        for (i = 0; i <= (MB-(1+1)); i = i+1)
            ho[i] = !ub[i+1] & ub[i];
        ho[MB-1] = ub[MB-1];
        for (i = 0; i <= (MB-1); i = i+1)
            if (!ub[i]) out[i*7 +: 7] = 7'b0;
              
        len[0] = |(32'b01010101010101010101010101010101 & ho);
        if (N > 7) len[1] = |(ho & 32'b01100110011001100110011001100110);
          
        if (N > 21) len[1+1] = |(32'b01111000011110000111100001111000 & ho);
          
        if (N > 49) len[3] = |(32'b01111111100000000111111110000000 & ho);
          
        if (N > 105) len[4] = |(32'b01111111111111111000000000000000 & ho);
          
      end
endmodule

