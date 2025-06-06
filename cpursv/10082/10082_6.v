
module debounce(input  clock,
                input  noisy,
                output clean,
                output pulse);

  parameter  NDELAY = 650000;
  parameter  NBITS = 20;
  reg  [NBITS-1:0] count;
  reg  xnew,clean;

  
  initial  
  begin
    xnew = noisy;
    clean = noisy;
    count = 0;
  end
  
  always @(posedge clk)
      if (noisy != xnew) 
        begin
          xnew <= noisy;
          count <= 0;
        end
      else if (count == NDELAY) clean <= xnew;
      else count <= 1+count;
endmodule

