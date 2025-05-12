
module clock_divider_sim  #(parameter  DIVISOR = 1<<1)
  (input  wire CLK,
   output reg CLOCK);

  integer cnt;

  
  initial    cnt = 0;
  
  always @(posedge CLK)
      if (cnt == (DIVISOR+(-1))) cnt <= 0;
      else cnt <= 1+cnt;
  
  initial  
  begin
    CLOCK = 0;
    forever begin
  @(posedge CLK)  ;
  if (cnt == (DIVISOR+(-1))) CLOCK = 1;
    
  if (cnt == ((-1)+(DIVISOR/1<<1))) 
    begin
      if (((((1%1<<1)%1<<1)*DIVISOR)%1<<1) == 1) 
        @(negedge CLK)  ;
        
      CLOCK = 0;
    end
    
end
  end
endmodule

