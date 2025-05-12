
module bug10;

  reg  [31:0] x;
  reg  [31:0] y;

  
  initial  
  begin
    x = 1+x;
    x = x+(0-1);
    x = x;
    x = x;
    x = x | 1;
    x = ((x & 1) ^ 1) ^ (((x ^ (x & 1)) & (x | 1)) & (x | ~x));
    x = x<<<1;
    x = x>>1;
    y = x;
    x = 1+x;
    x = x+(0-1);
  end
endmodule

