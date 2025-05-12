
module clockdiv(input  wire clk,
                input  wire rst,
                output wire logic_en,
                output wire logic_en_1,
                output wire pix_en,
                output wire display_en);

  reg  [17:0] q;

  
  always @(posedge clk)
      begin
        if (rst == 1) q <= 0;
        else q <= 1+q;
      end
  assign logic_en = ~q[0] & (~q[5] & ((((((~q[11] & (~q[6] & ~q[8])) & ((~q[9] & ~q[10]) & ((~q[12] & q[15]) & (~q[13] & ~q[14])))) & ~q[3]) & ~q[7]) & ~q[4]) & (~q[1] & ~q[2])));
  assign logic_en_1 = ((~q[3] & ~q[2]) & ~q[1]) & (q[0] & (~q[9] & ((~q[6] & ((~q[5] & ~q[4]) & ~q[7])) & ((~q[11] & ~q[8]) & ((~q[14] & q[15]) & ((~q[10] & ~q[13]) & ~q[12]))))));
  assign display_en = (~q[0] & ~q[2]) & (~q[1] & (((~q[10] & (~q[6] & ~q[5])) & (((~q[9] & ((~q[11] & q[14]) & ~q[13])) & ~q[12]) & ~q[7])) & ((~q[4] & ~q[3]) & ~q[8])));
  assign pix_en = ~q[1] & ~q[0];
endmodule

