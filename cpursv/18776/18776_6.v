
module gold(off,fib0,fib1,fib2,fib3,fib4,fib5,fib6,fib7,fib8,fib9);

  input  wire signed  [31:0] off;
  output Integer  fib0 = off;
  output Integer  fib1 = off+1;
  output Integer  fib2 = off+1;
  output Integer  fib3 = off+1<<1;
  output Integer  fib4 = off+3;
  output Integer  fib5 = off+5;
  output Integer  fib6 = 8+off;
  output Integer  fib7 = 13+off;
  output Integer  fib8 = 21+off;
  output Integer  fib9 = 34+off;


endmodule

