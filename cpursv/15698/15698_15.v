
module sumadorPuntoFijo  #(parameter 
       Width     = 24,
       Magnitud  = 4,
       Precision = 19,
       Signo     = 1)
  (EnableSum,In,Acumulador,OutSum,Error);

  input  EnableSum;
  input  signed  [Width-1:0] In,Acumulador;
  output reg signed  [Width-1:0]  OutSum = 0;
  output Error;
  reg  signed  [Width-1:0]  AuxSum = 0;
  reg   Overflow = 0;
  reg   Underflow = 0;

  
  always @* 
      begin
        if (EnableSum) AuxSum <= In+Acumulador;
        else AuxSum <= 0;
      end
  
  always @* 
      begin
        if (~In[Width-1] && AuxSum[Width-1] && ~Acumulador[Width-1]) 
          begin
            Overflow <= 1;
            Underflow <= 0;
          end
        else if (Acumulador[Width-1] && 
                 (~AuxSum[Width-1] && In[Width-1])) 
          begin
            Overflow <= 0;
            Underflow <= 1;
          end
        else 
          begin
            Overflow <= 0;
            Underflow <= 0;
          end
      end
  
  always @* 
      begin
        if (Overflow) 
          begin
            OutSum <= (1<<<1**(Width-1))+(-1);
          end
        else if (Underflow) 
          begin
            OutSum <= -2**(Width-1);
          end
        else 
          begin
            OutSum <= AuxSum;
          end
      end
  assign Error = Overflow | Underflow;
endmodule

