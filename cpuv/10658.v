module pwmod(
  output pwmseout,       
  input clk,             
  input currentlimit,    
  input [7:0] pwmcount,  
  input [7:0] pwmval);   
  reg pwmseo = 0;            
  reg [7:0] pwmsyncreg = 0;  
  reg [7:0] pwmval_clipped;   
  assign pwmseout = pwmseo;  
  always@(posedge clk) begin
    if(pwmcount == 8'hff) begin
      pwmsyncreg = pwmval_clipped;  
      pwmseo = 1;                   
    end
    else begin
      if((currentlimit == 1) || (pwmcount == pwmsyncreg)) begin
        pwmseo = 0;  
      end
    end
  end
  `ifndef WITH_DEADTIME
  always @(*) begin
    if(pwmval < `PWM_MIN)
      pwmval_clipped <= `PWM_MIN;  
    else if(pwmval > `PWM_MAX)
      pwmval_clipped <= `PWM_MAX;  
    else
      pwmval_clipped <= pwmval;    
  end
  `else
  always @(*) begin
    pwmval_clipped <= pwmval;  
  end
  `endif
endmodule