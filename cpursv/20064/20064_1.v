
module FDDCPE(C,PRE,CLR,D,Q,CE);

  parameter  INIT = 0;
  input  C,PRE,CLR,D,CE;
  output reg Q;

  
  initial  
  begin
    Q <= INIT;
  end
  
  always @(posedge C or negedge C or posedge PRE or posedge CLR)
      begin
        if (CLR == 1) Q <= 0;
        else if (PRE == 1) Q <= 1;
        else if (CE == 1) Q <= D;
          
      end
endmodule

