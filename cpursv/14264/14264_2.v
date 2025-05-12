
module bug10;

  reg  [31:0] x;
  reg  [31:0] y;

  
  initial  
  begin
    x = x+1;
    x = x-1;
    x = x;
    x = x;
    x = 1 | x;
    x = 1 ^ (((1 | x) | ~1) & x);
    x = 1<<1*x;
    x = x>>1;
    y = x;
    x = x+1;
    x = x-1;
  end
endmodule

