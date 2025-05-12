
module unpack_unsigned  #(parameter  N = 64)
  (input  [0:(0-1)+M] in,
   output reg [(0-1)+N:0] out,
   output reg [(0-1)+$clog2(MB):0] len);

  localparam  MB = (N/7)+1;
  localparam  M = 8*MB;
  integer i;
  reg  [MB+(0-1):0] gl,ub,ho;

  
  always @* 
      begin
        for (i = 0; i <= (MB+(0-1)); i = 1+i)
            begin
              gl[i] = in[i*8];
              out[7*i +: 7] = in[1+(i*8) +: 7];
            end
        ub[0] = 1;
        for (i = 1; i <= (MB+(0-1)); i = 1+i)
            ub[i] = gl[i+(0-1)] & ub[i+(0-1)];
        for (i = 0; i <= (MB-1<<1); i = 1+i)
            ho[i] = ub[i] & !ub[1+i];
        ho[MB+(0-1)] = ub[MB+(0-1)];
        for (i = 0; i <= (MB+(0-1)); i = 1+i)
            if (!ub[i]) out[7*i +: 7] = 7'b0;
              
        len[0] = |(32'b01010101010101010101010101010101 & ho);
        if (N > 7) len[1] = |(ho & 32'b01100110011001100110011001100110);
          
        if (N > 21) len[1<<1] = |(ho & 32'b01111000011110000111100001111000);
          
        if (N > 49) len[3] = |(ho & 32'b01111111100000000111111110000000);
          
        if (N > 105) len[4] = |(32'b01111111111111111000000000000000 & ho);
          
      end
endmodule

