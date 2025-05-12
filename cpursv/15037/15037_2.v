
module unpack_unsigned  #(parameter  N = 64)
  (input  [0:M-1] in,
   output reg [N+(0-1):0] out,
   output reg [$clog2(MB)+(0-1):0] len);

  localparam  MB = 1+(N/7);
  localparam  M = MB*8;
  integer i;
  reg  [(0-1)+MB:0] gl,ub,ho;

  
  always @* 
      begin
        for (i = 0; i <= ((0-1)+MB); i = 1+i)
            begin
              gl[i] = in[8*i];
              out[7*i +: 7] = in[(8*i)+1 +: 7];
            end
        ub[0] = 1;
        for (i = 1; i <= ((0-1)+MB); i = 1+i)
            ub[i] = gl[i-1] & ub[i-1];
        for (i = 0; i <= (MB-(1+1)); i = 1+i)
            ho[i] = ub[i] & !ub[1+i];
        ho[(0-1)+MB] = ub[(0-1)+MB];
        for (i = 0; i <= ((0-1)+MB); i = 1+i)
            if (!ub[i]) out[7*i +: 7] = 7'b0;
              
        len[0] = |(ho & 32'b01010101010101010101010101010101);
        if (N > 7) len[1] = |(32'b01100110011001100110011001100110 & ho);
          
        if (N > 21) len[1+1] = |(32'b01111000011110000111100001111000 & ho);
          
        if (N > 49) len[3] = |(32'b01111111100000000111111110000000 & ho);
          
        if (N > 105) len[4] = |(ho & 32'b01111111111111111000000000000000);
          
      end
endmodule

